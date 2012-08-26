package
{
import assets.Intro;
import assets.Logo;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import jp.raohmaru.toolkit.motion.Paprika;
import jp.raohmaru.toolkit.utils.WebUtil;

public class Intro extends Sprite
{
	private var _step :int = -1,
				_screens :Array = [assets.Intro,assets.Logo],
				_links :Array = ["http://ludumdare.com/compo/", "http://raohmaru.com"];
	
	public function Intro()
	{
		init();
	}
	
	private function init() :void
	{
		next();
	}
	
	private function next() :void
	{
		if(++_step < _screens.length)
		{
			var screen :Sprite = new _screens[_step]();
				screen.alpha = 0;
				screen.buttonMode = true;
				screen.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			addChild(screen);
			
			Paprika.add(screen, .5, {alpha:1});
			Paprika.add(screen, .5, {alpha:0}, null, 2, function():void {
				screen.removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
				removeChild(screen);
				next();
			});
		}
		else
			dispatchEvent(new Event(Event.COMPLETE));
	}
	
	private function mouseHandler(e :MouseEvent) :void
	{
		WebUtil.getURL(_links[_step], "_blank");
	}
}
}