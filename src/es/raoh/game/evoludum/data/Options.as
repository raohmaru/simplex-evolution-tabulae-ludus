package es.raoh.game.evoludum.data
{
public class Options
{
	public var	rows :uint = 5,
				cols :uint = 5,
				square_size :Number = 83,
				num_players :uint = 2,
				
				ini_level :uint = 1,
				max_level :uint = 5,
				win_level :uint = 5,
				min_score_level :int = 1,
				
				moves :Array = [
					[],
//					["+", "self","="],
//					["+", "opp", "=-1"],
//					["#", "opp", "=-1"],
//					["*", "opp", "=-1"]
					
					["+", "self", "="],
					["+", "self", "=-1"],
					["+", "self", "=-1"],
					["+", "self", "=-1"],
					["+", "both", "=-1"]
				];
	
	public function Options()
	{
	}
}
}