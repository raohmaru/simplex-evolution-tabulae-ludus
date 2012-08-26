package es.raoh.game.evoludum.core
{
public class TurnMachine
{
	private var _turn :int,
				_num_players :uint;
	
	public function get currentPlayerId():uint 
	{
		return _turn % _num_players;
	}
	
	public function TurnMachine(num_players :uint)
	{
		_num_players = num_players;
	}
	
	/**
	 * 
	 */
	public function reset() :void
	{
		_turn = -1;
	}
	
	/**
	 * 
	 */
	public function next() :void
	{
		_turn++;
	}
}
}