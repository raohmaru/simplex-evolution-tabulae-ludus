package es.raoh.game.evoludum.ctrls
{
import assets.MsgBox;

import es.raoh.game.evoludum.EvoLudum;
import es.raoh.game.evoludum.core.GameObject;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import jp.raohmaru.toolkit.motion.Paprika;

public class DialogBox extends GameObject
{
	private var _box :MovieClip,
				_callback :Function;
	private const	T_DIALOG :int = 1,
					T_MESSAGE :int = 2;
	
	public function DialogBox(game:EvoLudum)
	{
		super(game);
	}
	
	override protected function init() :void
	{
		super.init();
		
		_box = new assets.MsgBox();
		_box.ok_bot.addEventListener(MouseEvent.MOUSE_UP, buttonHandler);
		_box.cancel_bot.addEventListener(MouseEvent.MOUSE_UP, buttonHandler);
		_view.addChild( _box );
	}
	
	private function buttonHandler(e :MouseEvent) :void
	{
		if(e.target.name == "ok_bot")
		{
			if( _callback != null )
			{
				_callback.call();
				_callback = null;
			}
			close();
		}
			
		else if(e.target.name == "cancel_bot")
			close()
	}
	
	/**
	 * 
	 */
	public function dialog(title :String, msg :String) :DialogBox
	{
		show(title, msg, T_DIALOG);
		
		return this;
	}
	
	/**
	 * 
	 */
	public function message(title :String, msg :String) :DialogBox
	{
		show(title, msg, T_MESSAGE);
		
		return this;
	}
	
	/**
	 * 
	 */
	private function show(title :String, msg :String, type :int) :void
	{
		_box.title_tf.text = title;
		_box.msg_tf.text = msg;
		
		if(type == T_DIALOG)
		{
			_box.ok_bot.x = 182;
			_box.cancel_bot.visible = true;
		}
		else if(type == T_MESSAGE)
		{
			_box.ok_bot.x = 260;
			_box.cancel_bot.visible = false;
		}
		
		_game.view.addChild(_view);
		_view.alpha = 0;
		Paprika.add(_view, .2, {alpha:1});
	}
	
	/**
	 * 
	 */
	public function confirm(f :Function) :void
	{
		_callback = f;
	}
	
	/**
	 * 
	 */
	public function close() :void
	{
		Paprika.add(_view, .2, {alpha:0}).onComplete = function():void
		{
			if(_view.parent)
				_game.view.removeChild(_view);
		};
	}
}
}