package es.raoh.game.evoludum.data
{
public class Options
{
	public var	rows :uint = 5,
				cols :uint = 5,
				square_size :Number = 83,
				num_players :uint = 2,
				max_level :uint = 4,
				rules :Array = [
					[],
					["+", "self","="],
					["+", "opp", "=-1"],
					["#", "opp", "=-1"],
					["*", "opp", "=-1"]
				];
	
	public function Options()
	{
	}
}
}