package es.raoh.game.evoludum.data
{
import es.raoh.game.evoludum.events.GameEvent;

import flash.events.EventDispatcher;

public class GameData extends EventDispatcher
{
	private var _arr :Array,
				_vec :Vector.<SquareData>;
	
	public function GameData(rows:uint, cols:uint)
	{
		init(rows, cols);
	}
	
	/**
	 * 
	 */
	private function init(rows:uint, cols:uint) :void
	{
		_arr = [];
		_vec = new Vector.<SquareData>(rows*cols);
		var k :int;
		
		for (var i:int = 0; i < rows; i++) 
		{
			_arr[i] = [];
			for (var j:int = 0; j < cols; j++)
			{
				_arr[i][j] = new SquareData(i, j, k++);
			}
		}
		
		updateVector();
	}
	
	/**
	 * 
	 */
	public function squareAt(row:uint, col:uint) :SquareData
	{
		return _vec[row*_arr.length+col];
	}
	
	/**
	 * 
	 */
	public function updateSquare(sqd :SquareData) :void
	{
		_arr[sqd.row][sqd.col] = sqd;
		updateVector();
		dispatchEvent( new GameEvent(GameEvent.DATA_UPDATED) );
//		trace(this);
	}
	
	/**
	 * 
	 */
	private function updateVector() :void
	{
		var k :int = 0,
			rows :int = _arr.length,
			cols :int = _arr[0].length;
		
		for (var i:int = 0; i < rows; i++) 
		{
			for (var j:int = 0; j < cols; j++)
			{
				_vec[k++] = SquareData(_arr[i][j]).clone();
			}
		}
	}
	
	/**
	 * 
	 */
	public function toVector() :Vector.<SquareData>
	{
		return _vec;
	}
		
	override public function toString() : String 
	{
		var str :String = "";
		for (var i:int = 0; i < _arr.length; i++) 
		{
			for (var j:int = 0; j < _arr[i].length; j++)
				str += _arr[i][j] + " ";
			
			str += "\n";
		}
		
		return str;
	}
}
}