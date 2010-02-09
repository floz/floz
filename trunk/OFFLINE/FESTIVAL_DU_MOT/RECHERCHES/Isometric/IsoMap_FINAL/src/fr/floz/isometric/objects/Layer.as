
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.objects 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import fr.floz.isometric.core.IRenderable;
	import fr.floz.isometric.core.IsoDisplayObject;
	
	public class Layer extends Sprite implements IRenderable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _height:Number;
		private var _canvas:BitmapData;
		private var _objects:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------	
		
		public var needRender:Boolean;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Layer( width:Number, height:Number ) 
		{
			this._width = width;
			this._height = height;
			
			_canvas = new BitmapData( _width, _height, true, 0x00 );
			addChild( new Bitmap( _canvas ) );
			
			_objects = [];
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addObject( object:IsoDisplayObject ):Boolean
		{
			var i:int = _objects.length;
			_objects[ i ] = object;
			
			return _objects.length != i ? true : false;
		}
		
		public function render():void
		{
			var ido:IsoDisplayObject;
			
			_objects.sortOn( "depth", Array.NUMERIC );
			
			_canvas.fillRect( _canvas.rect, 0x00 );
			
			var n:int = _objects.length;
			for ( var i:int; i < n; ++i )
				_canvas.draw( _objects[ i ] );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}