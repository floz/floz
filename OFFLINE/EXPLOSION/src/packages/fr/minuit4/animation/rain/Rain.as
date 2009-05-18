
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.animation.rain
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Rain extends Bitmap
	{
		
		private const PIXEL_MOVE:Number = .18;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _target:DisplayObject;
		private var _pixels:Array;
		private var _image:BitmapData;
		
		private var _tmp:Array;
		
		private var _enable:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Rain( target:DisplayObject )
		{			
			this._target = target;
			super( null, PixelSnapping.AUTO, true );
			
			this._enable = true;
			
			create();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onFrame(e:Event):void 
		{
			render();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function destroy():void
		{
			if ( !_enable ) 
				return;
			
			_enable = false;
			
			_pixels = null;
			
			removeEventListener( Event.ENTER_FRAME, onFrame );
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		private function create():void
		{
			_image = new BitmapData( _target.width, _target.height, true, 0x00 );
			_image.draw( _target );			
			
			_pixels = [];
			var pixel:Pixel;
			var b:Boolean = true;
			var x:int = -1;
			var y:int;
			const w:int = _image.width;
			const h:int = _image.height;
			var c:uint;
			while ( true )
			{
				pixel = new Pixel( b ? ++x : --x, y, _image.getPixel32( x, y ) );
				
				_pixels.push( pixel );
				if ( x == w || x == -1 )
				{
					if ( ++y == h ) break;
					b = !b;
				}				
			}
			
			this.bitmapData = _image;
		}
		
		private function rain():void
		{
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function render():void
		{
			var pixel:Pixel;
			var i:int = _pixels.length;
			var py:int;
			var vy:Number;
			
			const h:Number = _image.height - 1;
			
			_tmp = [];
			
			_image.fillRect( _image.rect, 0x00 );
			_image.lock();	
			while ( --i > -1 )
			{
				pixel = _pixels[ i ];
				
				py = pixel.py;
				vy = pixel.vy;
				
				_image.setPixel32( pixel.px, py, pixel.c );
				
				vy += Math.random() / ( .5 / PIXEL_MOVE ) - PIXEL_MOVE;
				vy = vy < 0 ? -vy : vy;
				vy = vy + vy;		
				
				if ( py < h )
				{	
					py += vy;
					
					pixel.py = py;
					pixel.vy = vy;
					
					_tmp.push( pixel );
				}
			}
			_image.unlock();
			
			_pixels = _tmp;
			if ( !_pixels.length ) destroy();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function start():void
		{
			if ( !_enable ) throw new Error( "L'animation est maintenant terminée, créez une nouvelle instance de Rain pour pouvoir la rejouer." );			
			rain();
		}
		
		public function kill():void
		{
			destroy();
		}
		
		public function eraseBitmap():void
		{
			_image.dispose();
			_image = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}