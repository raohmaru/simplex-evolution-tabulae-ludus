package es.raoh.game.evoludum.data
{
public class SquareData
{	
	private var _row :uint,
				_col :uint,
				_idx :uint,
				_owner :int,
				_level :uint;
				
	public function get row():uint { return _row; }
	public function get col():uint { return _col; }
	public function get idx():uint { return _idx; }
	public function get owner():int { return _owner; }
	public function set owner(value:int):void 
	{
		_owner = value;
	}
	public function get level():uint { return _level; }
	public function set level(value:uint):void 
	{
		_level = value;
	}
	
	public function SquareData(row:uint, col:uint, idx:uint, owner:int=-1, level:uint=0)
	{
		_row = row;
		_col = col;
		_idx = idx;
		_owner = owner;
		_level = level;
	}
	
	/**
	 * 
	 */
	public function isEmpty() :Boolean
	{
		return _owner == -1;
	}
	
	/**
	 * 
	 */
	public function clone() :SquareData
	{
		return new SquareData(_row, _col, _idx, _owner, _level);
	}
	
	/**
	 * 
	 */
	public function clear() :void
	{
		_owner = -1;
		_level = 0;
	}
	
	/**
	 * 
	 */
	public function eq(obj:*, col:uint=0) :Boolean
	{
		if(obj is SquareData)
			return _row == obj.row && _col == obj.col;
		else
			return _row == obj && _col == col;
	}
	
	public function toString() : String 
	{
		return isEmpty() ? " 0 " : _owner+":"+_level;
	}
}
}