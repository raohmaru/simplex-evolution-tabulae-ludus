package es.raoh.game.evoludum.view
{
import flash.display.MovieClip;
import flash.utils.getDefinitionByName;

import jp.raohmaru.toolkit.motion.Paprika;
import jp.raohmaru.toolkit.motion.easing.Back;
import jp.raohmaru.toolkit.motion.easing.Quad;
import jp.raohmaru.toolkit.utils.MathUtil;

public class PieceView extends AbstractView
{
	private var _mc :MovieClip;
	
	public function set level(value :uint):void 
	{
		_mc.level_tf.text = value.toString();
		Paprika.add(_mc, .3, {scale: 1 + .25 * (value-1)}, Quad.easeOut);
	}
	
	public function PieceView(sym :String)
	{
		init(sym);
	}
	
	/**
	 * 
	 */
	private function init(sym :String) :void
	{
		var ClassRef :Class = getDefinitionByName("assets."+sym) as Class;
		_mc = new ClassRef() as MovieClip;
		addChild(_mc);
		
		_mc.scaleX = _mc.scaleY = 0;
	}
	
	public function mergeAndLevelUp(x :Number, y :Number, level :uint) :void
	{
		var s :Number = 1 + .25 * (level-1);
		
		parent.setChildIndex(this, parent.numChildren-1);
		
		Paprika.add(this, .5, {x:x, y:y}, Quad.easeOut, 0, function():void {
			_mc.level_tf.text = level.toString();
		});
		Paprika.add(_mc, .3, {scale: s}, Quad.easeInOut, .5);
	}
	
	public function disappear() :void
	{
		Paprika.wait(this, .5, 0, function():void {
			parent.removeChild(this);
		});
	}
	
	public function remove() :void
	{
		Paprika.add(this, .2, {scale: 0}, Quad.easeIn, MathUtil.random(.2), function():void {
			parent.removeChild(this);
		});
	}
}
}