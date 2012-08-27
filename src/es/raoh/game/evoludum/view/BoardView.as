package es.raoh.game.evoludum.view
{
import assets.Board;

import es.raoh.game.evoludum.ctrls.Piece;
import es.raoh.game.evoludum.core.Player;
import es.raoh.game.evoludum.data.GameData;
import es.raoh.game.evoludum.data.SquareData;
import es.raoh.game.evoludum.events.GameEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import jp.raohmaru.toolkit.motion.Paprika;
import jp.raohmaru.toolkit.motion.easing.Quad;

public class BoardView extends AbstractView
{
	private var _squares :Vector.<BoardSquareView>,
				_rows :uint,
				_cols :uint,
				_size :Number;
	
	public function BoardView(rows:uint, cols:uint, size:Number)
	{
		_rows = rows;
		_cols = cols;
		_size = size;
		
		init();
	}
	
	private function init() :void
	{
		x = 62;
		y = 27;
		addChild( new assets.Board() );
		
		_squares = new Vector.<BoardSquareView>();
		
		var sq_size :Number = _size,
			sq :BoardSquareView;
		for (var i:int = 0; i < _rows; i++) 
		{
			for (var j:int = 0; j < _cols; j++)
			{
				sq = new BoardSquareView(i, j, sq_size);
				sq.x = j * sq_size;
				sq.y = i * sq_size;
				sq.mouseEnabled = false;
				sq.addEventListener(MouseEvent.MOUSE_UP, squareMouseHandler);
				
				addChild( sq );
				_squares.push(sq);
			}
		}	
	}
	
	private function squareMouseHandler(e :MouseEvent) :void
	{
		dispatchEvent( new GameEvent(GameEvent.SQUARE_CLICK, {row:e.target.row, col:e.target.col}) );
	}
	
	public function prepare(player:Player, data :Vector.<SquareData>) :void
	{
		mouseChildren = true;
		
		for (var i:int = 0; i < _squares.length; i++)
		{
			_squares[i].mouseEnabled = player.isHuman() && (data[i].isEmpty() || data[i].owner == player.id );
			_squares[i].highlight = false;
		}
	}

	/**
	 * 
	 */
	public function highlightMoves(arr :Array) :void
	{
		mouseChildren = true;
		
		for (var i:int = 0; i < _squares.length; i++)
		{
			_squares[i].mouseEnabled = arr[i] != 0;
			_squares[i].highlight = arr[i] == 1;
		}
	}
	
	/**
	 * 
	 */
	public function addPiece(row:uint, col:uint, sp :Sprite) :void
	{
		sp.y = row * _size + _size/2;
		sp.x = col * _size + _size/2;
		
		addChild(sp);
	}
}
}