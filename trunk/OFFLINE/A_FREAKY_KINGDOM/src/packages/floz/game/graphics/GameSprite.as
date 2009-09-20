
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
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import floz.game.utils.AnimationParser;
	
	public class GameSprite extends Sprite
	{
		// - STATIC & CONST --------------------------------------------------------------
		
		public static const READY:String = "gamesprite_ready";
		
		private static const _readyEvent:Event = new Event( READY );
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _animsByLabels:Dictionary = new Dictionary( true );
		private var _labels:Array = [];
		
		private var _frameRate:int;
		private var _timer:Timer;
		
		private var _spriteHolder:Bitmap;
		
		private var _currentAnim:GameAnimation;
		
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
			_spriteHolder.bitmapData = _currentAnim.render();
		}
		
		private function onAnimationParsed(e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, onAnimationParsed);
			
			var gameAnim:GameAnimation;
			var label:String;
			var anims:Array = AnimationParser( e.currentTarget ).getAnimations();
			var n:int = anims.length;
			for ( var i:int; i < n; ++i )
			{
				gameAnim = anims[ i ].animation;
				label = anims[ i ].label;
				
				_animsByLabels[ label ] = gameAnim;
			}
			
			dispatchEvent( _readyEvent );
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
			var ap:AnimationParser = new AnimationParser( animation, animationDepth );
			ap.addEventListener( Event.COMPLETE, onAnimationParsed, false, 0, true );
			ap.parse();
		}
		
		public function addAnimationPart( animation:MovieClip, label:String, index:int = -1 ):void
		{
			
		}
		
		public function play( label:String ):void
		{
			_currentAnim = _animsByLabels[ label ];
			if ( !_currentAnim ) throw new Error( "Le label n'existe pas." );
			
			_timer.addEventListener( TimerEvent.TIMER, render, false, 0, true );
			_timer.start();
		}
		
		public function pause():void
		{
			_timer.stop();
		}
		
		public function stop():void
		{
			_timer.stop();
			_currentAnim.stop();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}