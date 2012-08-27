package es.raoh.game.evoludum.core
{
import es.raoh.game.evoludum.core.ai.DefaultAI;
import es.raoh.game.evoludum.core.ai.IAIEngine;
import es.raoh.game.evoludum.data.GameData;
import es.raoh.game.evoludum.data.SquareData;

public class Player
{
	public static const T_HUMAN :String = "human",
						T_AI :String = "ai";
	
	public var	name :String;
	private var _id :uint;
	public function get id():uint { return _id; }
	
	private var	_type :String;
	public function set type(value :String):void 
	{
		_type = value;
	}
	
	private var	_iaengine :IAIEngine;
	public function set iaengine(value :IAIEngine):void 
	{
		_iaengine = value;
	}
	
	public function get pieceSym():String 
	{
		return "Piece"+(_id+1);
	}
	
	public function Player(id :uint, name :String, type :String, iaengine:IAIEngine=null)
	{
		_id = id;
		this.name = name;
		_type = type;
		_iaengine = iaengine;
		
		if(_type == T_AI && _iaengine == null)
			_iaengine = new DefaultAI();
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
	public function getActions(data :GameData, ref :Referee) :Vector.<SquareData>
	{
		if(!isHuman())
			return _iaengine.getActions(data, _id, ref);
		
		return null;
	}
}
}