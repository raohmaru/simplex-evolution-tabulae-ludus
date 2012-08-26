package
{
import es.raoh.game.evoludum.EvoLudum;

import flash.display.Sprite;
import flash.display.StageScaleMode;

[SWF(width="640", height="480", backgroundColor="#FFFFFF", frameRate="60")]

public class Main extends Sprite
{
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
		
		var game :EvoLudum = new EvoLudum();
		addChild(game.view);
		game.start();
	}
}
}