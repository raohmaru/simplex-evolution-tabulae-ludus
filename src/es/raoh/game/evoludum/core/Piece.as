package es.raoh.game.evoludum.core
{
import es.raoh.game.evoludum.EvoLudum;
import es.raoh.game.evoludum.data.GameData;
import es.raoh.game.evoludum.data.SquareData;
import es.raoh.game.evoludum.view.PieceView;

import flash.display.MovieClip;
import flash.filters.GlowFilter;
import flash.utils.getDefinitionByName;

public class Piece extends GameObject
{
	private var _level :uint,
				_sym :String;
	private const GLOW :GlowFilter = new GlowFilter(0xFF0000, 1, 10, 10, 5);
	
	public function set highlight(value :Boolean):void 
	{
		_view.filters = value ? [GLOW] : [];
	}
	
	public function Piece(game :EvoLudum, data :GameData, sym :String, level :uint)
	{
		_sym = sym;
		_level = level;
		super(game, data);
	}
	
	override protected function init() :void
	{
		_view = new PieceView(_sym);
		PieceView(_view).level = _level;
		
		_view.mouseChildren = false;
		_view.mouseEnabled = false;
	}
	
	public function legalMoves(target :SquareData) :Array
	{
		var arr :Array = [],
			vec :Vector.<SquareData> = _data.toVector(),
			rulz :Rules = new Rules(_game.options.rules[target.level]),
			sqd :SquareData,
			pid :uint = _game.turn.currentPlayerId,
			c :uint = target.col,
			r :uint = target.row,
			level :uint = target.level + rulz.mod;
		
		for (var i:int = 0; i < vec.length; i++) 
		{
			sqd = vec[i];
			arr[i] = 0;
			
			if(sqd.eq(r,c))
			{
				arr[i] = 2;
			}
			
			if(
				!sqd.isEmpty() &&
				(rulz.canibal && sqd.owner == pid || !rulz.canibal && sqd.owner != pid) &&
				rulz.op == "=" && sqd.level == level &&
				((rulz.type == "+" || rulz.type == "#" || rulz.type == "*") &&
					(sqd.eq(r-1,c) || sqd.eq(r,c-1) || sqd.eq(r,c+1) || sqd.eq(r+1,c)) ||
				rulz.type == "#" &&
					(sqd.eq(r-2,c) || sqd.eq(r,c-2) || sqd.eq(r,c+2) || sqd.eq(r+2,c)) ||
				rulz.type == "*" &&
					(sqd.eq(r-1,c-1) || sqd.eq(r-1,c+1) || sqd.eq(r+1,c-1) || sqd.eq(r+1,c+1)))
			)
			{
				arr[i] = 1;
			}
		}
		
		return arr;
	}

	public function merge(p :Piece, level :uint) :void
	{
		_level = level;
		
		PieceView(_view).mergeAndLevelUp(p.view.x, p.view.y, _level);
		p.disappear();
	}
	
	public function disappear() :void
	{
		PieceView(_view).disappear();
		_view = null;
	}
	
	public function remove() :void
	{
		PieceView(_view).remove();
		_view = null;
	}
}
}

internal class Rules
{
	public var	type :String,
				canibal :Boolean,
				op :String = "=",
				mod :Number = 0;
	
	public function Rules(arr :Array) 
	{
		init(arr);
	}
	
	private function init(arr :Array) :void
	{
		type = arr[0];
		canibal = arr[1] == "self";
		
		var m :Array = String(arr[2]).match(/([^+\-0-9]+)(.*)/);
		if(m && m[1])
		{
			op = m[1];
			if(m[2])
				mod = Number(m[2]);
		}
	}
}