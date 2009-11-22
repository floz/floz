
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.wtf.misc 
{
	import com.wtf.engines.renderer.IRenderable;
	import flash.display.Sprite;
	
	public class MovieBitmap extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _animations:Object;
		private var _currentAnimation:AnimatedBitmap;
		
		private var _isPlaying:Boolean;
		private var _currentFrameId:String;
		
		private var _currentExpositionTick:int;
		private var _expositionTime:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MovieBitmap() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_animations = { };
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addAnimatedBitmap( animatedBitmap:AnimatedBitmap, frameId:String, defaultFrame:int = 0 ):void
		{
			animatedBitmap.defaultFrame = defaultFrame;
			_animations[ frameId ] = animatedBitmap;
		}
		
		public function play( frameId:String = "" ):void
		{
			if ( _isPlaying && frameId == _currentFrameId )
				return;
			
			_isPlaying = true;
			_currentExpositionTick = 0;
			
			if ( frameId != "" )
			{				
				while ( numChildren ) removeChildAt( 0 );
				_currentAnimation = _animations[ frameId ];
				if ( !_currentAnimation ) throw new Error( "L'id '" + frameId +"' n'existe pas." );
				addChild( _currentAnimation );
				
				_currentFrameId = frameId;
			}
		}
		
		public function stop():void
		{
			_isPlaying = false;
			_currentAnimation.gotoFrame( _currentAnimation.defaultFrame );
		}
		
		public function update():void
		{
			if ( _isPlaying )
			{
				++_currentExpositionTick;
				if ( _currentExpositionTick >= _expositionTime ) 
				{
					_currentAnimation.update();
					_currentExpositionTick = 0;
				}
			}
		}
		
		public function setDefaultAnimation( frameId:String ):void
		{
			var defaultAnimation:AnimatedBitmap = _animations[ frameId ];
			if ( !defaultAnimation ) throw new Error( "L'id '" + frameId +"' n'existe pas." );
			_currentAnimation = defaultAnimation;
			
			while ( numChildren ) removeChildAt( 0 );
			_currentAnimation.gotoFrame( _currentAnimation.defaultFrame );
			addChild( _currentAnimation );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function set expositionTime( value:int ):void
		{
			_expositionTime = value;
			_currentExpositionTick = 0;
		}
		public function get expositionTime():int { return _expositionTime; }
		
	}
	
}