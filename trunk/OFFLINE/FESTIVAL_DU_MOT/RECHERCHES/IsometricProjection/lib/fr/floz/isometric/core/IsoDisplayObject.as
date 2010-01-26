
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.core 
{
	import flash.display.Sprite;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	
	public class IsoDisplayObject extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _position:Point3D;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoDisplayObject() 
		{
			_position = new Point3D( 0, 0, 0 );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function updateScreenPosition():void
		{
			var pt:Point3D = IsoMath.isoToScreen( _position );
			super.x = pt.x;
			super.y = pt.y;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		override public function get x():Number { return _position.x; }
		
		override public function set x( value:Number ):void 
		{
			_position.x = value;
			updateScreenPosition();
		}
		
		override public function get y():Number { return _position.y; }
		
		override public function set y( value:Number ):void 
		{
			_position.y = value;
			updateScreenPosition();
		}
		
		override public function get z():Number { return _position.z; }
		
		override public function set z( value:Number ):void
		{
			_position.z = value;
			updateScreenPosition();
		}
		
		public function get depth():Number
		{
			return 0;
		}
		
	}
	
}