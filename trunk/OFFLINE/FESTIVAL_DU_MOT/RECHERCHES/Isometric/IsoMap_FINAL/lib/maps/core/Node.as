
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.core 
{
	
	public class Node
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var x:int;
		public var y:int;
		public var g:Number = 0;
		public var h:Number = 0;
		public var f:Number = 0;
		
		public var walkable:Boolean;
		public var parent:Node;
		
		public var closed:Boolean = false;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Node( x:int, y:int ) 
		{
			this.x = x;
			this.y = y;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function clone():Node
		{
			var n:Node = new Node( x, y );
			n.g = this.g;
			n.h = this.h;
			n.f = this.f;
			n.walkable = this.walkable;
			n.parent = this.parent;
			
			return n;
		}
		
		public function getRootNode():Node
		{
			var p:Node = parent;
			while ( p.hasParent() )
				p = p.parent;
			
			return p;
		}
		
		public function hasParent():Boolean
		{
			return parent ? true : false;
		}
		
		public function toString():String { return "Node( x: " + this.x + ", y : " + this.y + " )"; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}