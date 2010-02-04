﻿
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
			var n:Node = new Node();
			n.x = this.x;
			n.y = this.y;
			n.g = this.g;
			n.h = this.h;
			n.f = this.f;
			n.walkable = this.walkable;
			n.parent = this.parent;
			
			return n;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}