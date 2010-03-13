
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.core.paths.astar.heuristics 
{
	import fr.tilzy.core.paths.astar.Astar;
	
	public class Diagonal implements IHeuristic
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dx:Number;
		private var _dy:Number;		
		private var _vx:Number;
		private var _vy:Number;
		private var _diag:Number;
		private var _straight:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Diagonal() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getCost( x1:int, y1:int, x2:int, y2:int ):Number
		{
			_dx = x1 - x2;
			_vx = _dx < 0 ? -_dx : _dx;
			
			_dy = y1 - y2;
			_vy = _dy < 0 ? -_dy : _dy;
			
			_diag = _vx < _vy ? _vx : _vy; // _dx < _dy ? _dx : _dy; Meilleures perfs ?
			_straight = _vx + _vy;
			
			return Astar.DIAG_COST * _diag + Astar.STRAIGHT_COST * ( _straight - 2 * _diag );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}