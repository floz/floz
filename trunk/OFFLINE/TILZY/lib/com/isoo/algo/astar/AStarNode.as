package com.isoo.algo.astar
{
	import com.isoo.algo.geom.IntPoint;
	
	/**
	 * 	Defines a weighted point/tile for use in AStar
	 */
	public class AStarNode extends IntPoint
	{
		
		public var g:Number = 0;
		public var h:Number = 0;
		public var cost:Number = 1;
		public var walkable:Boolean;
		
		public var parent:AStarNode;		
		
		function AStarNode(x:int, y:int, walkable:Boolean=true)
		{
			super(x,y);
			this.walkable = walkable;
		}
		
		public function get f():Number 
		{
			return g+h;
		}
		
		public function size():int
		{
			if( parent != null )
				return 1 + parent.size();
			else
				return 1;
		}
	}
}