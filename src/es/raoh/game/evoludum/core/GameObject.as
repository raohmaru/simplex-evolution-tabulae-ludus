package es.raoh.game.evoludum.core
{
import es.raoh.game.evoludum.EvoLudum;

import flash.display.Sprite;
import flash.events.EventDispatcher;

public class GameObject extends EventDispatcher
{
	protected var _view :Sprite,
				  _game :EvoLudum;
	public function get view() :Sprite { return _view; }
	
	public function GameObject(game :EvoLudum)
	{
		_game = game;
		
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