package
{
import assets.Home;

import es.raoh.game.evoludum.events.GameEvent;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import jp.raohmaru.toolkit.motion.Paprika;
import jp.raohmaru.toolkit.utils.WebUtil;

public class Help extends Sprite
{
	private var _screen :MovieClip;
	
	public function Help()
	{
		init();
	}
	
	private function init() :void
	{
		_screen = new assets.Help();
		_screen.ok_bot.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
		addChild(_screen);
		
		alpha = 0;
		Paprika.add(this, .2, {alpha:1});
	}
	
	private function mouseHandler(e :MouseEvent) :void
	{
		Paprika.add(this, .2, {alpha:0}).onComplete = function() :void
		{
			if(parent)
				parent.removeChild(this);
		};
		
		_screen.ok_bot.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
		_screen = null;
	}
}
}