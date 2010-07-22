package com.gobzlite.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author David Ronai
	 */
	public class AnimateBitmapData extends Sprite
	{
		//static timer to animate all animateBitmap
		private static var shapeTimer:Shape;
		private static var animationToUpdate:/*AnimateBitmapData*/Array; 
		
		private var lastUpdate:int;
		
		private var currentFrame:int;
		private var totalFrames:int;
		private var _frames:Vector.<BitmapData>;
		private var bitmap:Bitmap;
		
		public function AnimateBitmapData() 
		{
			currentFrame = 0;
			totalFrames = 0;
			
			bitmap = new Bitmap();			
			addChild(bitmap);
			
			if ( shapeTimer == null ) {
				shapeTimer = new Shape();
				shapeTimer.addEventListener(Event.ENTER_FRAME, everyFrame);
				animationToUpdate = [];
			}
			
		}
		
		private function everyFrame(e:Event):void 
		{
			for ( var i:int = animationToUpdate.length-1; i > -1 ; i--) 
			{
				animationToUpdate[i].nextFrame();
			}
		}
		
		public function play():void
		{
			if ( animationToUpdate.indexOf( this ) == -1 ) {
				animationToUpdate[animationToUpdate.length] = this;
			}
		}
		
		public function stop():void
		{
			var idx:int = animationToUpdate.indexOf( this );
			if ( idx != -1 )
				animationToUpdate.splice(idx, 1);
		}
		
		public function nextFrame():void
		{
			currentFrame ++;
			if ( currentFrame >= totalFrames )
				currentFrame = 0;
			
			bitmap.bitmapData = _frames[currentFrame];
		}
		
		public function prevFrame():void
		{
			currentFrame --;
			if ( currentFrame < 0 )
				currentFrame = totalFrames-1;
			bitmap.bitmapData = _frames[currentFrame];
		}
		
		public function addFrame( bitmapData:BitmapData ):void
		{
			if ( _frames == null )
				_frames = new Vector.<BitmapData>();
			
			_frames[ _frames.length ] = bitmapData;
			totalFrames = _frames.length;
		}
		
		public function dispose():void
		{
			stop();
			bitmap.bitmapData = null;
			removeChild ( bitmap );
			bitmap = null;
			_frames = null;
		}
		
		public function get frames():Vector.<BitmapData> { return _frames; }		
		public function set frames( value:Vector.<BitmapData> ):void 
		{
			_frames = value;
			totalFrames = _frames.length;
		}
		
	}

}