package es.raoh.game.evoludum.core
{
import es.raoh.game.evoludum.EvoLudum;
import es.raoh.game.evoludum.data.GameData;
import es.raoh.game.evoludum.data.SquareData;
import es.raoh.game.evoludum.events.GameEvent;
import es.raoh.game.evoludum.view.BoardSquareView;
import es.raoh.game.evoludum.view.BoardView;

import flash.events.MouseEvent;

public class Board extends GameObject
{
	private var _board_view :BoardView,
				_pieces :Vector.<Piece>,
				_sqd :SquareData;
	
	public function Board(game :EvoLudum, data :GameData)
	{
		super(game, data);
	}
	
	/**
	 * 
	 */
	override protected function init() :void
	{
		super.init();
		
		_board_view = new BoardView(_game.options.rows, _game.options.cols, _game.options.square_size);
		_board_view.addEventListener(GameEvent.SQUARE_CLICK, viewEventHandler);
		_view.addChild( _board_view );
		
		_pieces = new Vector.<Piece>(_game.options.rows * _game.options.cols);
	}
	
	/**
	 * 
	 */
	private function viewEventHandler(e :GameEvent) :void
	{
		var player :Player = _game.players[_game.turn.currentPlayerId],
			sqd :SquareData = _data.squareAt(e.data.row, e.data.col);
		
		if(sqd.isEmpty())
		{
			addPiece(sqd.row, sqd.col, player.id);
			_game.nextTurn();
		}
		else
		{
			if(_sqd != null)
			{
				var piece :Piece = _pieces[_sqd.idx];
					piece.highlight = false;
				
				if(sqd.eq(_sqd))
					prepare();
				else
				{
					merge(_sqd, sqd);
					_game.nextTurn();
				}
				
				_sqd = null;
			}
			else
			{
				piece = _pieces[sqd.idx];
				piece.highlight = true;
				_board_view.highlightMoves( piece.legalMoves(sqd) );
				_sqd = sqd;
			}
		}
	}
	
	/**
	 * 
	 */
	public function addPiece(row:uint, col:uint, owner:uint, level:uint=1) :void
	{
		var player :Player = _game.players[owner],
			sqd :SquareData = _data.squareAt(row, col);
		
		sqd.owner = owner;
		sqd.level = level;
		
		_data.updateSquare(sqd);
		
		var piece :Piece = new Piece(_game, _data, player.pieceSym, level);
		
		_board_view.addPiece(row, col, piece.view);
		_pieces[sqd.idx] = piece;
	}
	
	
	
	/**
	 * 
	 */
	public function prepare() :void
	{
		_board_view.prepare(_game.players[_game.turn.currentPlayerId], _data.toVector());		
	}
	
	/**
	 * 
	 */
	private function merge(curr :SquareData, target :SquareData) :void
	{
		target.owner = curr.owner;
		target.level = curr.level + (curr.level < _game.options.max_level ? 1 : 0);
		_data.updateSquare(target);	
		
		curr.clear();
		_data.updateSquare(curr);
		
		_pieces[curr.idx].merge(_pieces[target.idx], target.level);
		_pieces[target.idx] = _pieces[curr.idx];
		_pieces[curr.idx] = null;
	}
}
}