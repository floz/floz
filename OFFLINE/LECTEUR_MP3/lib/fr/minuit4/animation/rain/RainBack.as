
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
	
	public class RainBack extends Bitmap
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
		
		public function RainBack( target:DisplayObject ) 
		{
			this._target = target;
			super( null, PixelSnapping.NEVER, true );
			
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
			const w:Number = _image.width;
			const h:Number = _image.height;
			var c:uint;
			while ( true )
			{
				currentPixel.px =  b ? ++x : --x;
				currentPixel.fy = y;
				currentPixel.py = h - 1;
				currentPixel.c = _image.getPixel32( x, y );
				
				++_pixelsCount;
				
				if ( x == w || x == -1 )
				{
					if ( ++y == h ) break;
					b = !b;
				}
				currentPixel = currentPixel.next = new Pixel();
			}
			
			_image.fillRect( _image.rect, 0x00 );
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
			var py:Number;
			var vy:Number;
			var fy:Number;
			
			var count:int;
			
			const h:Number = _image.height - 1;
			
			_image.lock();
			_image.fillRect( _image.rect, 0x00 );			
			while ( --i > -1 )
			{				
				py = pixel.py;
				vy = pixel.vy;
				fy = pixel.fy;
				
				_image.setPixel32( pixel.px, py, pixel.c );
				
				if ( pixel.end )
				{
					++count;
					pixel = pixel.next;
					continue;
				}
				
				vy -= Math.random() / ( .5 / PIXEL_MOVE ) - PIXEL_MOVE;
				vy = vy > 0 ? -vy : vy;
				vy = vy + vy;	
				
				if ( py > fy )
				{	
					py += vy;
					py = py <= fy ? fy : py;
					
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