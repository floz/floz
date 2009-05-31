
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
		private var _pixels:Pixel;
		private var _image:BitmapData;
		
		private var _pixelsCount:int;
		
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
			
			removeEventListener( Event.ENTER_FRAME, onFrame );
			dispatchEvent( new Event( Event.COMPLETE ) );
			
			_enable = false;
			
			_pixels = null;
		}
		
		private function create():void
		{
			_image = new BitmapData( _target.width, _target.height, true, 0x00 );
			_image.draw( _target );			
			
			_pixels = new Pixel();
			var currentPixel:Pixel = _pixels;
			
			var b:Boolean = true;
			var x:int = -1;
			var y:int;
			const w:int = _image.width;
			const h:int = _image.height;
			while ( true )
			{				
				currentPixel.px = b ? ++x : --x;
				currentPixel.py = y;
				currentPixel.c = _image.getPixel32( x, y );
				
				++_pixelsCount;
				
				if ( x == w || x == -1 )
				{
					if ( ++y == h ) break;
					b = !b;
				}
				
				currentPixel = currentPixel.next = new Pixel();
			}
			
			this.bitmapData = _image;
		}
		
		private function rain():void
		{
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function render():void
		{
			var pixel:Pixel = _pixels;
			var i:int = _pixelsCount;
			var py:int;
			var vy:Number;
			
			const h:Number = _image.height - 1;
			var count:int;
			
			_image.fillRect( _image.rect, 0x00 );
			_image.lock();	
			while ( --i > -1 )
			{
				py = pixel.py;
				vy = pixel.vy;
				
				_image.setPixel32( pixel.px, py, pixel.c );
				
				if ( pixel.end )
				{
					pixel = pixel.next;
					++count;
					continue;
				}
				
				vy += Math.random() / ( .5 / PIXEL_MOVE ) - PIXEL_MOVE;
				vy = vy < 0 ? -vy : vy;
				vy = vy + vy;		
				
				if ( py < h )
				{	
					py += vy;
					
					pixel.py = py;
					pixel.vy = vy;
				}
				else
				{
					pixel.end = true;
					++count;
				}
				
				pixel = pixel.next;
			}
			_image.unlock();
			
			if ( count == _pixelsCount ) destroy();
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