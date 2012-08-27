package
{
import assets.Home;

import es.raoh.game.evoludum.events.GameEvent;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import jp.raohmaru.toolkit.motion.Paprika;
import jp.raohmaru.toolkit.utils.WebUtil;

public class Home extends Sprite
{
	public function Home()
	{
		init();
	}
	
	private function init() :void
	{
		var screen :MovieClip = new assets.Home();
			screen.play_bot.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			screen.play2_bot.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			screen.help_bot.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			screen.logo_bot.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
		addChild(screen);
		
		alpha = 0;
		Paprika.add(this, .5, {alpha:1});
	}
	
	/**
	 * 
	 */
	public function show() :void
	{
		Paprika.add(this, .5, {autoAlpha:1});
	}
	
	private function mouseHandler(e :MouseEvent) :void
	{
		if(e.target.name == "play_bot")
		{
			Paprika.add(this, .5, {autoAlpha:0}, null, 0, function():void
			{
				dispatchEvent(new GameEvent(GameEvent.START));
			});
		}
		else if(e.target.name == "play2_bot")
		{
			Paprika.add(this, .5, {autoAlpha:0}, null, 0, function():void
			{
				dispatchEvent(new GameEvent(GameEvent.START2));
			});
		}
		else if(e.target.name == "help_bot")
			dispatchEvent(new GameEvent(GameEvent.HELP));
			
		else if(e.target.name == "logo_bot")
			WebUtil.getURL("http://raohmaru.com", "_blank");
	}
}
}