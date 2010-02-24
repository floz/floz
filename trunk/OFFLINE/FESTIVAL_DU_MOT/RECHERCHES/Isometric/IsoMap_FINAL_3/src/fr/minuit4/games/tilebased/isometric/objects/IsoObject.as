
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.isometric.objects 
{
	import flash.display.Sprite;
	import fr.minuit4.games.tilebased.common.objects.GameObject;
	import fr.minuit4.games.tilebased.isometric.geom.IsoMath;
	import fr.minuit4.geom.Point3D;
	
	public class IsoObject extends GameObject
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _position:Point3D;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoObject() 
		{
			_position = new Point3D();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function updatePosition():void
		{
			var p:Point3D = IsoMath.isoToScreen( _position.x, _position.y, _position.z );
			super.x = p.x;
			super.y = p.y;
			
			invalidate();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get realX():Number { return super.x; }
		
		public function set realX( value:Number ):void
		{
			var p:Point3D = IsoMath.screenToIso( value, super.y, z );
			super.x = p.x;
		}
		
		public function get realY():Number { return super.y; }
		
		public function set realY( value:Number ):void
		{
			var p:Point3D = IsoMath.screenToIso( super.x, value, z );
			super.y = p.y;
		}
		
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
		
		override public function get z():Number { return _position.z; }
		
		override public function set z(value:Number):void 
		{
			_position.z = value;
			updatePosition();
		}
		
		override public function get depth():Number
		{
			return ( ( x + y ) * .866 - z * .707 );
		}
		
	}
	
}