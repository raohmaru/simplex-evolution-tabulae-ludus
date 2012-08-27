package es.raoh.game.evoludum.data
{
import es.raoh.game.evoludum.events.GameEvent;

import flash.events.EventDispatcher;

public class GameData extends EventDispatcher
{
	private var _arr :Array,
				_rows :uint,
				_cols :uint;
	
	public function GameData(rows:uint, cols:uint)
	{
		_rows = rows;
		_cols = cols;
		
		clear();
	}
	
	/**
	 * 
	 */
	public function clear() :void
	{
		_arr = [];
		var k :int;
		
		for (var i:int = 0; i < _rows; i++) 
		{
			_arr[i] = [];
			for (var j:int = 0; j < _cols; j++)
			{
				_arr[i][j] = new SquareData(i, j, k++);
			}
		}
		
		dispatchEvent( new GameEvent(GameEvent.DATA_UPDATED) );
	}
	
	/**
	 * 
	 */
	public function squareAt(row:uint, col:uint) :SquareData
	{
		if(row >= _rows || col >= _cols)
			return null;
		
		return SquareData(_arr[row][col]).clone();
	}
	
	/**
	 * 
	 */
	public function updateSquare(sqd :SquareData) :void
	{
		_arr[sqd.row][sqd.col] = sqd;
		dispatchEvent( new GameEvent(GameEvent.DATA_UPDATED) );
//		trace(this);
	}

	
	/**
	 * 
	 */
	public function toVector() :Vector.<SquareData>
	{
		var	vec :Vector.<SquareData> = new Vector.<SquareData>,
			k :int = 0;
		
		for (var i:int = 0; i < _rows; i++) 
		{
			for (var j:int = 0; j < _cols; j++)
			{
				vec[k++] = SquareData(_arr[i][j]).clone();
			}
		}
		
		return vec;
	}
		
	override public function toString() : String 
	{
		var str :String = "";
		for (var i:int = 0; i < _rows; i++) 
		{
			for (var j:int = 0; j < _arr[i].length; j++)
				str += _arr[i][j] + " ";
			
			str += "\n";
		}
		
		return str;
	}
}
}