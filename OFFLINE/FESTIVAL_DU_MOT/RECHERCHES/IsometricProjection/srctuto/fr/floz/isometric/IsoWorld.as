
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric 
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class IsoWorld extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _floor:Sprite;
		private var _objects:Array;
		private var _world:Sprite;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoWorld() 
		{
			_floor = new Sprite();
			addChild( _floor );
			
			_world = new Sprite();
			addChild( _world );
			
			_objects = [];
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addChildToWorld( child:IsoObject ):void
		{
			_world.addChild( child );
			_objects.push( child );
			sort();
		}
		
		public function addChildToFloor( child:IsoObject ):void
		{
			_floor.addChild( child );
		}
		
		public function sort():void
		{
			_objects.sortOn( "depth", Array.NUMERIC );
			for ( var i:int; i < _objects.length; ++i )
			{
				_world.setChildIndex( _objects[ i ], i );
			}
		}
		
		public function canMove( obj:IsoObject ):Boolean
		{
			var r:Rectangle = obj.rect;
			r.offset( obj.vx, obj.vz );
			
			var n:int = _objects.length;
			for ( var i:int; i < n; ++i )
			{
				var o:IsoObject = _objects[ i ] as IsoObject;
				if ( obj != o && !o.walkable && r.intersects( o.rect ) )
					return false;
			}
			return true;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}