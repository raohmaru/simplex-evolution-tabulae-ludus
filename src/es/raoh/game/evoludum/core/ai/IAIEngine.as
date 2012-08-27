package es.raoh.game.evoludum.core.ai
{
import es.raoh.game.evoludum.core.Referee;
import es.raoh.game.evoludum.data.GameData;
import es.raoh.game.evoludum.data.SquareData;

public interface IAIEngine
{
	function getActions(data :GameData, pid :uint, ref :Referee) :Vector.<SquareData>;
}
}