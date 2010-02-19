
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.scenes.tiles 
{
	import fr.minuit4.games.tilebased.geom.IsoMath;
	import fr.minuit4.games.tilebased.materials.Material;
	import fr.minuit4.geom.Point3D;
	
	public class TileIso extends Tile
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _position:Point3D;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TileIso( material:Material, size:int ) 
		{
			super( material, size );
			_position = new Point3D();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function initDatas():void 
		{
			var p1:Point3D = IsoMath.isoToScreen( _size, 0 );
			var p2:Point3D = IsoMath.isoToScreen( _size, _size );
			var p3:Point3D = IsoMath.isoToScreen( 0, _size );
			
			_DATAS[ 0 ] = 0;
			_DATAS[ 1 ] = 0;
			
			_DATAS[ 2 ] = p1.x;
			_DATAS[ 3 ] = p1.y;
			
			_DATAS[ 4 ] = p2.x;
			_DATAS[ 5 ] = p2.y;
			
			_DATAS[ 6 ] = p3.x;
			_DATAS[ 7 ] = p3.y;
			
			_DATAS[ 8 ] = 0;
			_DATAS[ 9 ] = 0;
		}
		
		private function updatePosition():void
		{
			var p:Point3D = IsoMath.isoToScreen( _position.x, _position.y, _position.z );
			super.x = p.x;
			super.y = p.y;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		override public function get x():Number { return _position.x; }
		
		override public function set x(value:Number):void 
		{
			_position.x = value;
			updatePosition();
		}
		
		override public function get y():Number { return _position.y; }
		
		override public function set y(value:Number):void 
		{
			_position.y = value;
			updatePosition();
		}
		
	}
	
}