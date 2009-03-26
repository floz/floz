
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class MapZoomHolder extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _px:Number;
		private var _py:Number;
		
		private var _zoomMap:Bitmap;
		
		private var _display:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cntZoom:Sprite;
		public var mapStrk:Sprite;
		public var background:Sprite;
		
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MapZoomHolder() 
		{
			_px = this.width * .5;
			_py = this.height * .5;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			_zoomMap = new Bitmap( Model.map, PixelSnapping.AUTO, true );
			_zoomMap.x = -_zoomMap.width * .5;
			_zoomMap.y = -_zoomMap.height * .5;
			cntZoom.addChild( _zoomMap );
		}
		
		public function zoom():void
		{
			cntZoom.x = _px - Model.currentItem.coordX;
			cntZoom.y = _py - Model.currentItem.coordY;
			
			this.alpha = .5;
			this.visible = true;
			
			TweenLite.to( this, .4, { alpha: 1, ease: Quad.easeOut } );
			_display = true;
		}
		
		public function hide():void
		{
			this.visible = false;
			_display = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get display():Boolean { return _display; }
		
	}
	
}