package com.isoo.objects
{
	import com.isoo.IsoScene;
	import com.isoo.map.Layer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.isoo.geom.Point3D;
	import com.isoo.map.Map;
	import com.isoo.map.Tile;
	import com.isoo.utils.IsoUtils;
	
	public class IsoObject extends Sprite
	{
		protected var _position:Point3D;
		protected var _walkable:Boolean;
		protected var _layer:Layer;
		protected var _scene:IsoScene;
		
		public function IsoObject()
		{
			_walkable = false;
			_position = new Point3D();
			updateScreenPosition();
		}
		
		protected function updateScreenPosition():void
		{
			var screenPos:Point = IsoUtils.isoToScreen( _position.x, _position.y, _position.z );
			x = screenPos.x ;
			y = screenPos.y ;
		}
		
		public function set position(value:Point3D):void
		{
			_position = value;
			updateScreenPosition();
		}
		public function get position():Point3D
		{
			return _position;
		}
		
		public function get depth():Number
		{
			//_position = IsoUtils.screenToIso(x, y);
			if ( _scene != null ) {
				var normalY:Number = (2 * y - x);
				var normalX:Number = (x + normalY / 2) * 2;
				
				return normalY * _scene.map.width + normalX//*Math.SQRT2// * _scene.map.height;
				//return caseY + caseX * _scene.map.height;
			}
			return 0;
		}
		
		public function get walkable():Boolean	{return _walkable;}
		public function set walkable(value:Boolean):void
		{
			_walkable = value;
		}
		
		public function get caseX():Number { return IsoUtils.screenToIso(x, y).x; }
		public function set caseX(value:Number):void
		{
			_position.x = value;
			updateScreenPosition();
		}
		public function get caseY():Number	{ return IsoUtils.screenToIso(x, y).y; }
		public function set caseY(value:Number):void
		{
			_position.y = value;
			updateScreenPosition();
		}
		
		public function registerToScene(scene:IsoScene):void {
			_scene = scene;
		}
		
		public function unregisterFromScene():void {
			_scene = null;
		}
		
		public function registerToLayer(layer:Layer):void {
			_layer = layer;
		}
		
		public function unregisterFromLayer():void {
			_layer = null;
		}
		
		public function isRegisterToLayer(layer:Layer):Boolean{
			return _layer == layer;
		}
		
		public function render():void {
			if ( _layer != null )
				_layer.renderObject( this );
		}
		
		override public function get x():Number { return super.x+Tile.Width * .5; }
		override public function set x(value:Number):void 
		{
			render(); super.x = value-Tile.Width*.5 ;
		}
		
		override public function set y(value:Number):void 	{	render(); super.y = value;	}
	}
}