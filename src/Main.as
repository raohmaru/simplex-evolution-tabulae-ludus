package
{
import es.raoh.game.evoludum.EvoLudum;
import es.raoh.game.evoludum.events.GameEvent;

import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.Event;

import jp.raohmaru.toolkit.motion.Paprika;

[SWF(width="640", height="480", backgroundColor="#D4D4D4", frameRate="60")]

public class Main extends Sprite
{
	private var _game :EvoLudum,
				_home :Home;
	
	public function Main()
	{
		init();
	}
	
	/**
	 * 
	 */
	private function init() :void
	{
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
		var intro :Intro = new Intro();
			intro.addEventListener(Event.COMPLETE, start);
		addChild(intro);
	}
	
	private function start(e :Event) :void
	{
		removeChild( Intro(e.target) );
		e.target.removeEventListener(Event.COMPLETE, start);
		
		_home = new Home();
		_home.addEventListener(GameEvent.START, gameStart);
		addChild(_home);
	}
	
	private function gameMenu(e :GameEvent) :void
	{
		Paprika.add(_game.view, .5, {autoAlpha:0}, null, 0, _home.show);
	}
	
	private function gameStart(e :GameEvent) :void
	{		
		if( _game == null )
		{
			_game = new EvoLudum();
			_game.view.alpha = 0;
			_game.addEventListener(GameEvent.EXIT, gameMenu);
			addChild(_game.view);
		}		
		
		_game.start();
		Paprika.add(_game.view, .5, {autoAlpha:1});
	}
}
}