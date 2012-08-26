package es.raoh.game.evoludum.core
{
import assets.HUD;

import es.raoh.game.evoludum.EvoLudum;
import es.raoh.game.evoludum.data.GameData;
import es.raoh.game.evoludum.events.GameEvent;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import jp.raohmaru.toolkit.motion.Paprika;

public class HUD extends GameObject
{
	private var _hud :MovieClip;
	
	public function HUD(game:EvoLudum, data:GameData)
	{
		super(game, data);
	}
	
	override protected function init() :void
	{
		super.init();
		
		_hud = new assets.HUD();
		_view.addChild(_hud);
		
		_hud.restart_bot.addEventListener(MouseEvent.MOUSE_UP, buttonHandler);
		_hud.quit_bot.addEventListener(MouseEvent.MOUSE_UP, buttonHandler);
		
		_data.addEventListener(GameEvent.DATA_UPDATED, dataHandler);
	}
	
	private function dataHandler(e :GameEvent) :void
	{
		for (var i:int = 0; i < _game.players.length; i++) 
		{
			var score :uint = _data.getScore(_game.players[i].id);
			_hud['score'+i].text = score;
		}
	}
	
	private function buttonHandler(e :MouseEvent) :void
	{
		if(e.target.name == "restart_bot")
			_game.start();
		
		else if(e.target.name == "quit_bot")
			_game.quit();
	}
	
	/**
	 * 
	 */
	public function updateTurn() :void
	{
		var pid :uint = _game.turn.currentPlayerId;
		for (var i:int = 0; i < _game.players.length; i++)
			Paprika.add(_hud['turn'+i], .1, {alpha: _game.players[i].id==pid ? 1 : .2 });
	}
}
}