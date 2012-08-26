package es.raoh.game.evoludum.events 
{
import flash.events.Event;

/**
 * @author raohmaru
 */
public class GameEvent extends Event
{
	public static const SQUARE_CLICK :String = "squareClick",
						DATA_UPDATED :String = "dataUpdated";
	
	private var _data :*;
	public function get data() :*
	{
		return _data;
	}
	
	public function GameEvent(type :String, data :*=null)
	{
		_data = data;
		super(type, bubbles, cancelable);
	}
	
	override public function toString() :String
	{
		return formatToString("CollectionEvent", "type", "data", "bubbles", "cancelable");
	}

	override public function clone() :Event
	{
		return new GameEvent(type, data);
	}
}
}
