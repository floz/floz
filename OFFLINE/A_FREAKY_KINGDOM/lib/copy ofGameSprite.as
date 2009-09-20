
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package floz.game.graphics 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class GameSprite extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _animsByLabels:Dictionary = new Dictionary( true );
		private var _labels:Array = [];
		
		private var _frameRate:int;
		private var _timer:Timer;
		
		private var _spriteHolder:Bitmap;
		
		private var _initialized:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GameSprite( frameRate:int ) 
		{
			this._frameRate = frameRate;
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function render(e:TimerEvent):void 
		{
			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			initEngine();
		}
		
		private function initEngine():void
		{
			_spriteHolder = new Bitmap( null, PixelSnapping.NEVER, true );
			addChild( _spriteHolder );
			
			_timer = new Timer( 1000 / _frameRate, 0 );
			_timer.addEventListener( TimerEvent.TIMER, render, false, 0, true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addAnimation( animation:MovieClip, animationDepth:int = 0, index:int = -1 ):void
		{
			if ( animationDepth > 1 ) throw new Error( "C'est pas la fête à la maison non plus." );
			if ( animationDepth == 1 && animation.numChildren > 1 ) throw new Error( "Hey mon gars..." );
			
			var anim:Animation;
			var anims:Array;
			var currentLabel:String;
			var i:int, j:int, framesCount:int;
			var labelsCount:int = animation.currentLabels.length;
			if ( animationDepth == 0 )
			{
				framesCount = animation.totalFrames;
				for ( ; i < labelsCount; ++i )
				{
					currentLabel = animation.currentLabel;
					anims = _animsByLabels[ currentLabel ] || [];
					
					anim = new Animation();
					for ( ; j < framesCount; ++j )
					{
						if ( currentLabel != animation.currentLabel ) break;
						anim.addFrame( animation );
						animation.nextFrame();
					}
					trace( anim.totalFrames );
					anims.push( anim );
					_animsByLabels[ currentLabel ] = anims;
				}
			}
			else if ( animationDepth == 1 )
			{
				var scope:MovieClip;
				for ( ; i < labelsCount; ++i )
				{					
					animation.gotoAndStop( animation.currentLabels[ i ].name );
					scope = animation.getChildAt( 0 ) as MovieClip;
					trace( scope );
					
					framesCount = scope.totalFrames;
					anims = _animsByLabels[ animation.currentLabels[ i ] ] || [];
					
					anim = new Animation();
					for ( j = 0; j < framesCount; ++j )
					{
						anim.addFrame( scope );
						scope.nextFrame();
					}
					anims.push( anim );
					_animsByLabels[ animation.currentLabels[ i ] ] = anims;
				}
			}			
		}
		
		public function addAnimationPart( animation:MovieClip, label:String, index:int = -1 ):void
		{
			
		}
		
		public function play( label:String ):void
		{
			
		}
		
		public function pause():void
		{
			
		}
		
		public function stop():void
		{
			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}

import flash.display.BitmapData;
import flash.display.DisplayObject;

final class Animation
{
	private var _frames:/*BitmapData*/Array;
	private var _idx:int;
	
	public var totalFrames:int;
	
	public function Animation()
	{
		_frames = [];
	}
	
	public function addFrame( frame:DisplayObject ):void
	{
		var bd:BitmapData = new BitmapData( frame.width, frame.height, true, 0x00 );
		bd.draw( frame );
		
		_frames.push( bd );
		++totalFrames;
	}
	
	public function render():BitmapData
	{
		var bd:BitmapData = _frames[ _idx ];
		_idx = int( _idx + 1 ) > int( totalFrames - 1 ) ? 0 : int( _idx + 1 );
		return bd;
	}
	
	public function dispose():void
	{
		for ( var i:int; i < totalFrames; ++i )
		{
			_frames[ i ].dispose();
			_frames[ i ] = null;
		}
		_frames = null;
	}
}