
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
	import flash.display.DisplayObjectContainer;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class Rain extends EventDispatcher
	{
		
		private const PIXEL_MOVE:Number = .18;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		static private var _instances:Dictionary = new Dictionary();
		static private var _allowInstance:Boolean;
		static private var _numExplosions:int;
		
		private var _target:DisplayObject;
		private var _pixels:Array;
		private var _pixelsEnd:Array;
		private var _image:BitmapData;
		private var _imageHolder:Bitmap;
		
		private var _timer:Timer;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Rain( target:DisplayObject ) 
		{
			if ( !Rain._allowInstance ) throw new Error( "Cette classe ne peut pas être instanciée. Veuillez appeller la méthode static apply()" );
			Rain._allowInstance = false;
			
			if ( !target.parent ) 
			{
				destroy();
				return;
			}
			
			this._target = target;
			
			Rain._instances[ this ] = true;
			Rain._numExplosions++;
			
			create();
			explode();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onFrame(e:Event):void 
		{
			render();
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			destroy();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function destroy():void
		{
			if ( !Rain._instances[ this ] ) return;
			
			delete Rain._instances[ this ];
			Rain._numExplosions--;
			
			_imageHolder.removeEventListener( Event.ENTER_FRAME, onFrame );
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
			var w:Number = _image.width;
			var h:Number = _image.height;
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
			
			_imageHolder = new Bitmap( _image, PixelSnapping.AUTO, true );
			_imageHolder.x = _target.x;
			_imageHolder.y = _target.y;
			
			var targetParent:DisplayObjectContainer = _target.parent;
			while ( targetParent.numChildren ) targetParent.removeChildAt( 0 );
			targetParent.addChild( _imageHolder );
		}
		
		private function explode():void
		{
			_timer = new Timer( _imageHolder.height * 2.5, 1 );
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			_timer.start();
			
			_imageHolder.addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function render():void
		{
			var pixel:Pixel;
			var i:int = _pixels.length;
			var py:Number;
			var vy:Number;
			
			const h:Number = _image.height - 1;
			
			_image.lock();
			_image.fillRect( _image.rect, 0x00 );			
			while ( --i > -1 )
			{
				pixel = _pixels[ i ];
				
				py = pixel.py;
				vy = pixel.vy;
				
				vy += Math.random() / ( .5 / PIXEL_MOVE ) - PIXEL_MOVE;
				if ( vy < 0 ) vy *= -1;
				vy = vy + vy;
				
				_image.setPixel32( pixel.px, py, pixel.c );			
				
				if ( py < h )
				{				
					py += vy;				
					
					pixel.py = py;
					pixel.vy = vy;
				}
			}
			_image.unlock();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		static public function apply( target:DisplayObject ):Rain
		{
			Rain._allowInstance = true;
			return new Rain( target );
		}
		
		static public function get numExplosions():int
		{
			return Rain._numExplosions;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}