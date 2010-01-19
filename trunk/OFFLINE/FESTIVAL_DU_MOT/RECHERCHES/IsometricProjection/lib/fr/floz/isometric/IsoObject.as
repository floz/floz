
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class IsoObject extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _position:Point3D;		
		
		protected var _vx:Number = 0;
		protected var _vy:Number = 0;
		protected var _vz:Number = 0;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var size:Number;
		public var walkable:Boolean;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoObject( size:Number ) 
		{
			this.size = size;
			this._position = new Point3D();
			
			updateScreenPosition();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function updateScreenPosition():void
		{
			var sp:Point = UIso.isoToScreen( _position );
			super.x = sp.x;
			super.y = sp.y;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setPosition( position:Point3D ):void 
		{ 
			this._position = position;
			updateScreenPosition();
		}
		
		public function getPosition():Point3D { return this._position; }		
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		override public function set x( value:Number ):void 
		{
			_position.x = value;
			updateScreenPosition();
		}
		override public function get x():Number { return _position.x; }
		
		override public function set y( value:Number ):void 
		{
			_position.y = value;
			updateScreenPosition();
		}
		override public function get y():Number { return _position.y; }
		
		override public function set z( value:Number ):void 
		{
			_position.z = value;
			updateScreenPosition();
		}
		override public function get z():Number { return _position.z; }
		
		public function get rect():Rectangle
		{
			return new Rectangle( _position.x - size * .5, _position.z - size * .5, size, size );
		}
		
		public function get depth():Number
		{
			return ( ( _position.x + _position.z ) * .866 - _position.y * .707 );
		}
		
		public function get vx():Number { return _vx; }
		
		public function set vx(value:Number):void 
		{
			_vx = value;
		}
		
		public function get vy():Number { return _vy; }
		
		public function set vy(value:Number):void 
		{
			_vy = value;
		}
		
		public function get vz():Number { return _vz; }
		
		public function set vz(value:Number):void 
		{
			_vz = value;
		}
		
	}
	
}