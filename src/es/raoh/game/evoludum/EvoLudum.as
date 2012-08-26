package es.raoh.game.evoludum
{
import es.raoh.game.evoludum.core.*;
import es.raoh.game.evoludum.data.*;
import es.raoh.game.evoludum.events.GameEvent;

import flash.display.Sprite;

public class EvoLudum extends GameObject
{
	private var	_board :Board,
				_turn :TurnMachine,
				_players :Vector.<Player>,
				_hud :HUD,
				_options :Options;
				
	public function get turn():TurnMachine { return _turn; }
	public function get players():Vector.<Player> { return _players; }
	public function get options():Options { return _options; }
	
	public function EvoLudum()
	{
		super(this, null);
	}
	
	/**
	 * 
	 */
	override protected function init() :void
	{
		super.init();
		
		_options = new Options();
		
		_data = new GameData(_options.rows, _options.cols);
		
		_hud = new HUD(this, _data);
		_view.addChild( _hud.view );
		
		_board = new Board(this, _data);
		_view.addChild( _board.view );
		
		_players = new Vector.<Player>();
		for (var i:int = 0; i < _options.num_players; i++)
			_players.push( new Player(i, Player.T_HUMAN) );
//		_players[0].type = Player.T_HUMAN;
		
		_turn = new TurnMachine(_options.num_players);
	}
	
	/**
	 * 
	 */
	public function start() :void
	{
		/*_board.addPiece(0,2,1,2);
		_board.addPiece(1,2,0,1);
		_board.addPiece(1,3,0,2);
		_board.addPiece(2,3,1,1);
		_board.addPiece(2,2,1,2);
		_board.addPiece(3,2,0,3);
		_board.addPiece(3,0,1,2);
		_board.addPiece(3,3,1,4);
		_board.addPiece(4,2,0,3);
		_board.addPiece(4,3,0,3);
		_board.addPiece(4,4,0,3);*/
		
		_data.clear();
		_turn.reset();
		_board.reset();
		nextTurn();
	}
	
	/**
	 * 
	 */
	public function nextTurn() :void
	{
		_turn.next();
		_board.prepare();
		_hud.updateTurn();
		_players[_turn.currentPlayerId].play();
	}
	
	/**
	 * 
	 */
	public function quit() :void
	{
		dispatchEvent( new GameEvent(GameEvent.EXIT) );
	}
}
}