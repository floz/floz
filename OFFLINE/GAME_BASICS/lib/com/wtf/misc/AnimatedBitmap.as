
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.wtf.misc 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class AnimatedBitmap extends Bitmap
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const POINT:Point = new Point( 0, 0 );
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _buffer:BitmapData;
		private var _rendererRect:Rectangle;
		private var _currentFrame:int;
		private var _framesCount:int;
		
		private var _framesPos:Vector.<int>;
		
		private var _defaultFrame:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AnimatedBitmap( bitmapData:BitmapData, width:Number, height:Number, pixelSnapping:String = "auto", smoothing:Boolean = false ) 
		{
			super( new BitmapData( width, height, true, 0x00 ), pixelSnapping, smoothing );
			
			_buffer = bitmapData.clone();
			init();			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_framesCount = _buffer.width / this.width;
			_rendererRect = new Rectangle( 0, 0, this.width, this.height );
			
			precalculateFramePos();			
			draw();			
		}
		
		private function precalculateFramePos():void
		{
			_framesPos = new Vector.<int>( _framesCount, true );
			for ( var i:int; i < _framesCount; ++i )
				_framesPos[ i ] = i * this.width;
		}
		
		private function draw():void
		{
			this.bitmapData.lock();
			this.bitmapData.copyPixels( _buffer, _rendererRect, POINT );
			this.bitmapData.unlock();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update():void
		{
			++_currentFrame;
			if ( _currentFrame >= _framesCount ) _currentFrame = 0;
			_rendererRect.x = _framesPos[ _currentFrame ];
			
			draw();
		}
		
		public function gotoFrame( frameIdx:int ):void
		{
			if ( frameIdx < 0 || frameIdx > _framesCount )
				frameIdx = _currentFrame;
			
			_currentFrame = frameIdx;
			_rendererRect.x = _framesPos[ frameIdx ];
			draw();
		}
		
		public function dispose():void
		{
			this.bitmapData.dispose();
			_rendererRect = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get buffer():BitmapData { return _buffer; }
		
		public function set defaultFrame(value:int):void 
		{
			_defaultFrame = value;
		}
		public function get defaultFrame():int { return _defaultFrame; }
		
	}
	
}