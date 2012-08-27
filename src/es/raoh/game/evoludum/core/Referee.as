package es.raoh.game.evoludum.core
{
import es.raoh.game.evoludum.EvoLudum;
import es.raoh.game.evoludum.data.Options;
import es.raoh.game.evoludum.data.SquareData;

public class Referee
{
	private var _game :EvoLudum;
	
	public function Referee(game :EvoLudum)
	{
		_game = game;
	}
	
	public function legalMoves(target :SquareData, onlyIndexes :Boolean=false) :Array
	{
		var arr :Array = [],
			vec :Vector.<SquareData> =_game.data.toVector(),
			m :Moves = new Moves(_game.options.moves[target.level]),
			sqd :SquareData,
			pid :uint = _game.turn.currentPlayerId,
			c :uint = target.col,
			r :uint = target.row,
			level :uint = target.level + m.mod,
			i :int = vec.length;
	
		if(onlyIndexes)
			var idxs :Array = [];
		
		while(--i > -1)
		{
			sqd = vec[i];
			arr[i] = 0;
			
			if(sqd.eq(r,c))
			{
				arr[i] = 2;
				continue;
			}
			
			if(
				!sqd.isEmpty() &&
				(m.predator || m.canibal && sqd.owner == pid || !m.canibal && sqd.owner != pid) &&
				m.op == "=" && sqd.level == level &&
				((m.type == "+" || m.type == "#" || m.type == "*") &&
					(sqd.eq(r-1,c) || sqd.eq(r,c-1) || sqd.eq(r,c+1) || sqd.eq(r+1,c)) ||
					m.type == "#" &&
					(sqd.eq(r-2,c) || sqd.eq(r,c-2) || sqd.eq(r,c+2) || sqd.eq(r+2,c)) ||
					m.type == "*" &&
					(sqd.eq(r-1,c-1) || sqd.eq(r-1,c+1) || sqd.eq(r+1,c-1) || sqd.eq(r+1,c+1)))
			)
			{
				arr[i] = 1;
				if(onlyIndexes)
					idxs[idxs.length] = i;
			}
		}
		
		return onlyIndexes ? idxs : arr;
	}

	public function levelUp(curr :SquareData, target :SquareData) :uint
	{
		return curr.level + (curr.level < _game.options.max_level ? 1 : 0);
	}
	
	public function getScore(playerid :uint) :uint
	{
		var score :uint,
			v :Vector.<SquareData> = _game.data.toVector(),
			i :int = v.length,
			j :int = _game.options.min_score_level,
			sqd :SquareData;
		while(--i > -1)
		{
			sqd = v[i];
			if(sqd.owner == playerid && sqd.level > j)
				score += sqd.level;
		}
		
		return score;
	}
	
	public function checkWinConditions() :Boolean
	{
		var score :uint,
		v :Vector.<SquareData> = _game.data.toVector(),
			i :int = v.length,
			j :int = _game.options.win_level,
			sqd :SquareData;
		while(--i > -1)
		{
			sqd = v[i];
			if(sqd.level >= j)
				return true;
		}
		
		return false;
	}
}
}

internal class Moves
{
	public var	type :String,
				canibal :Boolean,
				predator :Boolean,
				op :String = "=",
				mod :Number = 0;
	
	public function Moves(arr :Array) 
	{
		init(arr);
	}
	
	private function init(arr :Array) :void
	{
		type = arr[0];
		canibal  = arr[1] == "self";
		predator = arr[1] == "both";
		
		var m :Array = String(arr[2]).match(/([^+\-0-9]+)(.*)/);
		if(m && m[1])
		{
			op = m[1];
			if(m[2])
				mod = Number(m[2]);
		}
	}
}