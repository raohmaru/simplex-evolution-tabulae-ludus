package es.raoh.game.evoludum.core.ai
{
import es.raoh.game.evoludum.core.Referee;
import es.raoh.game.evoludum.data.GameData;
import es.raoh.game.evoludum.data.SquareData;

import jp.raohmaru.toolkit.utils.ArrayUtil;
import jp.raohmaru.toolkit.utils.MathUtil;
import jp.raohmaru.toolkit.utils.VectorUtil;

public class DefaultAI implements IAIEngine
{
	public var	eat :Number = 90,
				place :Number = 90,
				bother :Number = 70;
	
	public function DefaultAI()
	{
	}
	
	public function getActions(d :GameData, pid :uint, ref :Referee) :Vector.<SquareData>
	{
		var v :Vector.<SquareData> = d.toVector(),
			res :Vector.<SquareData> = new Vector.<SquareData>(),
			mine :Vector.<SquareData> = new Vector.<SquareData>(),
			opp :Vector.<SquareData> = new Vector.<SquareData>(),
			empty :Vector.<SquareData> = new Vector.<SquareData>(), 
			i :int = v.length,
			j :int, k :int, n :int,
			sqd :SquareData,
			arr :Array, c :int, r :int,
			danger :Boolean;
		
		while(--i > -1)
		{
			sqd = v[i];
			if(sqd.isEmpty())
				empty[k++] = sqd;
			
			else if(sqd.owner == pid)
				mine[j++] = sqd;
			
			else
			{
				opp[n++] = sqd;
				if(!danger && sqd.level >= 3)
					danger = true;
			}
		}
		
		// If I have any piece
		if( mine.length > 0 )
		{			
			// Eat?
			if( mine.length > 1 && MathUtil.randomBool(eat) )
			{
				trace( "Eating..." );
				mine.sort(byLevel);
				i = mine.length;
				while(--i > -1)
				{
					sqd = mine[i];
					arr = ref.legalMoves(sqd, true);
					if(arr.length > 0)
					{
						res[0] = sqd;
						res[1] = v[arr[MathUtil.randomInt(arr.length-1)]];
						break;
					}
				}
			}
			
			// Put a piece near other piece of mine
			if( res.length == 0 && MathUtil.randomBool(place) )
			{
				trace( "Placing..." );
				sqd = null;
				mine.sort(byLevel);
				i = mine.length;
				while(--i > -1 && sqd == null)
				{
					r = mine[i].row;
					c = mine[i].col;
					arr = ArrayUtil.shuffle( [ [r-1,c], [r,c-1], [r,c+1], [r+1,c] ] );
					for (j = 0; j < arr.length; j++) 
					{
						sqd = d.squareAt(arr[j][0], arr[j][1]);
						if(sqd && sqd.isEmpty())
						{
							res[0] = sqd;
							break;
						}
						sqd = null;
					}
				}
			}
		}
		
		// Bother the opponent?
		if( res.length == 0 && (danger || MathUtil.randomBool(bother)) )
		{
			trace( "Bothering..." );
			sqd = null;
			// VectorUtil.shuffle(opp);
			opp.sort(byLevel);
			i = opp.length;
			while(--i > -1 && sqd == null)
			{
				r = opp[i].row;
				c = opp[i].col;
//				arr = ArrayUtil.shuffle( [
//					[r-1,c-1], [r-1,c], [r-1,c+1],
//					[r,c-1], 		 	[r,c+1],
//					[r+1,c-1], [r+1,c], [r+1,c+1]
//				] );
				arr = [ [r-1,c], [r,c-1], [r,c+1], [r+1,c] ];
				for (j = 0; j < arr.length; j++) 
				{
					sqd = d.squareAt(arr[j][0], arr[j][1]);
					if(sqd && sqd.isEmpty())
					{
						res[0] = sqd;
						break;
					}
					sqd = null;
				}
			}
		}
		
		// If I have not put any piece...
		if(res.length == 0 && empty.length > 0)
			res[0] = empty[ MathUtil.randomInt(empty.length-1) ];
		
		return res;
	}
	
	private function byLevel(p1 :SquareData, p2 :SquareData) :int
	{
		return p1.level - p2.level;
	}
}
}