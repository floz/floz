﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.isometric.objects 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import fr.tilzy.common.objects.GameObject;
	import fr.tilzy.core.geom.Point3D;
	import fr.tilzy.isometric.geom.IsoMath;
	
	public class IsoObject extends GameObject
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _asset:DisplayObject;
		private var _position:Point3D;
		
		private var _sizeW:Number;
		private var _sizeL:Number;
		private var _sizeH:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoObject( asset:DisplayObject = null ) 
		{
			if ( asset )
				addChild( asset );
			
			_position = new Point3D();
			setSize();
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
		
		public function setSize( sizeW:Number = 32, sizeL:Number = 32, sizeH:Number = 32 ):void
		{
			this._sizeW = sizeW;
			this._sizeL = sizeL;
			this._sizeH = sizeH;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get realX():Number { return super.x; }
		
		public function set realX( value:Number ):void
		{
			super.x = value;
		}
		
		public function get realY():Number { return super.y; }
		
		public function set realY( value:Number ):void
		{
			super.y = value;
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
			return ( ( x + _sizeW * .5 + y + _sizeL * .5 ) * .866 - z  * .707 ); // z + _sizeH à imlémenter
		}
		
	}
	
}