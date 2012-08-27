package es.raoh.game.evoludum.ctrls
{
import es.raoh.game.evoludum.EvoLudum;
import es.raoh.game.evoludum.data.GameData;
import es.raoh.game.evoludum.data.SquareData;
import es.raoh.game.evoludum.view.PieceView;

import flash.display.MovieClip;
import flash.filters.GlowFilter;
import flash.utils.getDefinitionByName;
import es.raoh.game.evoludum.core.GameObject;

public class Piece extends GameObject
{
	private var _level :uint,
				_sym :String;
	private const GLOW :GlowFilter = new GlowFilter(0xFF0000, 1, 10, 10, 5);
	
	public function set highlight(value :Boolean):void 
	{
		_view.filters = value ? [GLOW] : [];
	}
	
	public function Piece(game :EvoLudum, sym :String, level :uint)
	{
		_sym = sym;
		_level = level;
		super(game);
	}
	
	override protected function init() :void
	{
		_view = new PieceView(_sym);
		PieceView(_view).level = _level;
		
		_view.mouseChildren = false;
		_view.mouseEnabled = false;
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