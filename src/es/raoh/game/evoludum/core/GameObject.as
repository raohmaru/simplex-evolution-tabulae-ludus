package es.raoh.game.evoludum.core
{
import es.raoh.game.evoludum.EvoLudum;
import es.raoh.game.evoludum.data.GameData;

import flash.display.Sprite;
import flash.events.EventDispatcher;

public class GameObject extends EventDispatcher
{
	protected var _view :Sprite,
				  _game :EvoLudum,
				  _data :GameData;
	public function get view() :Sprite { return _view; }
	
	public function GameObject(game :EvoLudum, data :GameData)
	{
		_game = game;
		_data = data;
		
		init();
	}
	
	/**
	 * 
	 */
	protected function init() :void
	{
		_view = new Sprite();
	}
}
}