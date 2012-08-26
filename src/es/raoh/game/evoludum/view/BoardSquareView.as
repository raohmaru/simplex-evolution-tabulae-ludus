package es.raoh.game.evoludum.view
{

import flash.display.Sprite;
import flash.events.MouseEvent;

import jp.raohmaru.toolkit.events.EventGroup;
import jp.raohmaru.toolkit.events.EventRegister;
import jp.raohmaru.toolkit.motion.Paprika;

public class BoardSquareView extends AbstractView
{
	private var _row :uint,
				_col :uint,
				_highlighted :Boolean;
	
	public function get row():uint { return _row; }
	public function get col():uint { return _col; }
	
	public function set highlight(value :Boolean):void 
	{
		_highlighted = value;
		Paprika.add(this, .2, {alpha : value ? 1 : 0});
	}
	
	public function BoardSquareView(row:uint, col:uint, size :Number)
	{
		_row = row;
		_col = col;
		
		init(size);
	}
	
	/**
	 * 
	 */
	private function init(size :Number) :void
	{
		alpha = 0;
		
		graphics.beginFill(0x1876D0, .5);
		graphics.lineStyle(4, 0x1876D0);
		graphics.drawRect(0, 0, size, size);
		graphics.endFill();
		
		EventRegister.addEventsListener(this, mouseHandler, EventGroup.BUTTON_EVENTS);
	}
	
	/**
	 * 
	 */
	private function mouseHandler(e :MouseEvent) :void
	{
		if(e.type == MouseEvent.MOUSE_DOWN)
		{
			Paprika.add(this, .2, {alpha:0});
		}
		else if(e.type == MouseEvent.MOUSE_UP)
		{
		}
		else if(e.type == MouseEvent.MOUSE_OVER)
		{
			Paprika.add(this, .2, {alpha:1});
		}
		else if(e.type == MouseEvent.MOUSE_OUT)
		{
			if(_highlighted)
				return;
			Paprika.add(this, .2, {alpha:0});
		}
	}
	
	override public function toString() : String 
	{
		return "[BoardSquare row="+_row+", col="+_col+"]";
	}
	
}
}