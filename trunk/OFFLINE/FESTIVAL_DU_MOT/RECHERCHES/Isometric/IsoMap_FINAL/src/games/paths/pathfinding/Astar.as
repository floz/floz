
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.paths.pathfinding 
{
	import flash.geom.Point;
	import games.scenes.maps.IMap;
	
	public class Astar 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _map:IMap;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Astar( map:IMap ) 
		{
			this._map = map;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function findPath( start:Point, end:Point ):void
		{
			// todo : changer le void
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}

final internal class Node
{
	public var x:int;
	public var y:int;
	
	public var g:Number;
	public var h:Number;
	public var f:Number;
	
	public var walkable:Boolean;
	public var parent:Node;
	
	public function Node( x:int, y:int )
	{
		this.x = x;
		this.y = y;
	}
	
}