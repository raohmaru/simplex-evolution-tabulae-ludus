package es.raoh.game.evoludum.core
{
public class Player
{
	public static const T_HUMAN :String = "human",
						T_AI :String = "ai";
	
	private var _id :uint;
	public function get id():uint { return _id; }
	
	private var	_type :String;
	public function set type(value :String):void 
	{
		_type = value;
	}
	
	public function get pieceSym():String 
	{
		return "Piece"+(_id+1);
	}
	
	public function Player(id :uint, type :String=T_AI)
	{
		_id = id;
		_type = type;
	}
	
	/**
	 * 
	 */
	public function isHuman() :Boolean
	{
		return _type == T_HUMAN;
	}
	
	/**
	 * 
	 */
	public function play() :void
	{
		
	}
}
}