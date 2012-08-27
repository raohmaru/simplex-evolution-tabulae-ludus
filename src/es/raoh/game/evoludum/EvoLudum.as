package es.raoh.game.evoludum
{
import es.raoh.game.evoludum.core.*;
import es.raoh.game.evoludum.ctrls.*;
import es.raoh.game.evoludum.data.*;
import es.raoh.game.evoludum.events.GameEvent;

import jp.raohmaru.toolkit.motion.Paprika;

public class EvoLudum extends GameObject
{
	private var	_board :Board,
				_data :GameData,
				_turn :TurnMachine,
				_players :Vector.<Player>,
				_hud :HUD,
				_options :Options,
				_ref :Referee,
				_msg :DialogBox;
				
	public function get turn():TurnMachine { return _turn; }
	public function get players():Vector.<Player> { return _players; }
	public function get options():Options { return _options; }
	public function get data():GameData { return _data; }
	public function get ref():Referee { return _ref; }
	public function get msg():DialogBox { return _msg; }
	
	public function set numPlayers(value:uint):void 
	{
		_players[1].type = value == 1 ? Player.T_AI : Player.T_HUMAN;
		_players[1].name = value == 1 ? "Ludum Dominus" : "Player Two";
	}
	
	public function EvoLudum()
	{
		super(this);
	}
	
	/**
	 * 
	 */
	override protected function init() :void
	{
		super.init();
		
		_options = new Options();
		_ref = new Referee(this);
		_msg = new DialogBox(this);
		
		_data = new GameData(_options.rows, _options.cols);
		
		_hud = new HUD(this);
		_view.addChild( _hud.view );
		
		_board = new Board(this);
		_view.addChild( _board.view );
		
		var arr :Array = [
			["Player One", Player.T_HUMAN],
			["Ludum Dominus", Player.T_AI]
		];
		_players = new Vector.<Player>();
		for (var i:int = 0; i < _options.num_players; i++)
			_players.push( new Player(i, arr[i][0], arr[i][1]) );
		
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
		
		var player :Player = _players[_turn.currentPlayerId];
		if(!player.isHuman())
		{
			var actions :Vector.<SquareData> = player.getActions(_data, _ref);
			for (var i:int = 0; i < actions.length; i++)
				Paprika.wait(this, 1+.5*i, 0, _board.action, [actions[i].row, actions[i].col]);
		}
	}
	
	/**
	 * 
	 */
	public function win() :void
	{
		Paprika.wait(this, 1.2, 0, function():void
		{
			var player :Player = _players[_turn.currentPlayerId],
				t :String = player.isHuman() ?
					"We Have a Winner!" : "You Have Lost the Game",
				m :String = player.name + " has won the game by evolving a chip to level "+_options.win_level+".\n\nThanks for playing.";
			
			_game.msg.message(t, m).confirm(quit);
		});
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