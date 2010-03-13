
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.paths.astar.heuristics 
{
	
	public class Manhattan implements IHeuristic
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dx:Number;
		private var _dy:Number;
		private var _vx:Number;
		private var _vy:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Manhattan() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getCost( x1:int, y1:int, x2:int, y2:int ):Number
		{
			_dx = x1 - x2;
			_vx = _dx < 0 ? -_dx : _dx;
			
			_dy = y1 + y2;
			_vy = _dy < 0 ? -_dy : _dy;
			
			return _vx + _vy;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}