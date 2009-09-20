
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package floz.game.utils 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import floz.game.core.GameEngine;
	import floz.game.graphics.GameAnimation;
	
	public class AnimationParser extends EventDispatcher
	{
		// - STATIC & CONST --------------------------------------------------------------
		
		private const _completeEvent:Event = new Event( Event.COMPLETE );
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _mc:MovieClip;
		private var _animationDepth:int;
		
		private var _anims:/*Object*/Array;
		private var _currentLabel:String;
		private var _labelIdx:int;
		
		private var _requestRender:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AnimationParser( mc:MovieClip, animationDepth:int = 0 ) 
		{
			if ( animationDepth < 0 || animationDepth > 1 || ( animationDepth == 1 && mc.numChildren > 1 ) )
				throw new Error( "error" );
			
			GameEngine.addParsedObject( mc );
			
			this._mc = mc;
			this._animationDepth = animationDepth;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRender(e:Event):void 
		{
			if ( !_requestRender ) return;
			_requestRender = false;
			
			var anim:GameAnimation = new GameAnimation();
			var scope:MovieClip = _mc.getChildAt( 0 ) as MovieClip;
			var framesCount:int = scope.totalFrames;
			for ( var i:int; i < framesCount; ++i )
			{
				anim.addFrame( scope );
				scope.nextFrame();
			}
			_anims.push( { label: _currentLabel, animation: anim } );
			
			if ( int( _labelIdx + 1 ) < int( _mc.currentLabels.length ) )
			{
				++_labelIdx;
				depthParsing();
			}
			else 
			{
				_mc.removeEventListener( Event.RENDER, onRender );
				GameEngine.disposeParsedObject( _mc );
				dispatchEvent( _completeEvent );
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function simpleParsing():void
		{
			var anim:GameAnimation;
			var i:int, j:int;
			var framesCount:int = _mc.totalFrames;
			var labelsCount:int = _mc.currentLabels.length;
			for ( i; i < labelsCount; ++i )
			{
				_currentLabel = _mc.currentLabel;
				anim = new GameAnimation();
				for ( j; j < framesCount; ++j )
				{
					if ( _currentLabel != _mc.currentLabel ) break;
					anim.addFrame( _mc );
					_mc.nextFrame();
				}
				_anims.push( { label: _currentLabel, animation: anim } );
			}
			
			dispatchEvent( _completeEvent );
		}
		
		private function depthParsing():void
		{
			_requestRender = true;
			
			_currentLabel = _mc.currentLabels[ _labelIdx ].name;
			_mc.gotoAndStop( _mc.currentLabels[ _labelIdx ].frame );
			GameEngine.stage.invalidate();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function parse():void
		{
			_anims = [];			
			if ( _animationDepth == 0 )
				simpleParsing();
			else
			{
				_mc.addEventListener( Event.RENDER, onRender );
				_currentLabel = _mc.currentLabels[ _labelIdx ].name;
				_requestRender = true;
				onRender( null );
			}
		}
		
		public function getAnimations():Array { return _anims; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}