package es.raoh.game.evoludum.core
{
import es.raoh.game.evoludum.EvoLudum;
import es.raoh.game.evoludum.data.GameData;
import es.raoh.game.evoludum.events.GameEvent;

import flash.display.Sprite;

public class GameObject
{
	protected var _view :Sprite,
				  _game :EvoLudum,
				  _data :GameData;
	public function get view() :Sprite { return _view; }
	
	public function GameObject(game :EvoLudum, data :GameData)
	{
		_game = game;
		_data = data;
		if(_data)
			_data.addEventListener(GameEvent.DATA_UPDATED, dataHandler);
		
		init();
	}
	
	/**
	 * 
	 */
	protected function init() :void
	{
		_view = new Sprite();
	}
	
	protected function dataHandler(e :GameEvent) :void
	{
		
	}
}
}