
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package floz.game.graphics 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class GameSprite_ extends Sprite
	{
		
		// - CONST -----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _animsByLabels:Dictionary = new Dictionary( true );
		private var _labels:/*String*/Array = [];
		private var _maxWidth:Number = 0, _maxHeight:Number = 0;
		private var _timer:Timer;
		
		private var _swf:MovieClip;
		private var _frameRate:int;
		private var _animHolder:Bitmap;
		
		private var _currentAnim:/*BitmapData*/Array;
		private var _currentLabel:String;
		private var _idx:int;
		private var _totalLabelFrames:int;
		
		private var _playing:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GameSprite_( swf:MovieClip, frameRate:int = 24 ) 
		{
			this._swf = swf;
			this._frameRate = frameRate;
			
			initEngine();
			initSprite();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true );
			
			initDisplay();
		}
		
		private function render( e:Event ):void
		{
			_animHolder.bitmapData = _currentAnim[ _idx ].clone();
			_idx = int( _idx + 1 ) > int( _totalLabelFrames - 1 ) ? 0 : int( _idx + 1 );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initEngine():void
		{
			_animHolder = new Bitmap( null, PixelSnapping.NEVER, true );
			addChild( _animHolder );
			
			_timer = new Timer( 1000 / _frameRate, 0 );
		}
		
		private function initSprite():void
		{
			var anim:Array;
			var tmpLabel:String;
			var bd:BitmapData;
			var mx:Matrix;
			var rect:Rectangle;
			
			var j:int;
			var framesCount:int = _swf.totalFrames;
			var labelsCount:int = _swf.currentLabels.length;
			for ( var i:int; i < labelsCount; ++i )
			{
				anim = [];				
				tmpLabel = _swf.currentLabel;
				for ( ; j < framesCount; ++j )
				{
					if ( _swf.currentLabel != tmpLabel ) break;
					
					rect = _swf.getBounds( _swf );
					mx = new Matrix();
					mx.translate( -rect.x, -rect.y );
					bd = new BitmapData( _swf.width + 1, _swf.height + 1, true, 0x00 );
					bd.draw( _swf, mx );
					anim.push( bd );
					
					_swf.nextFrame();
				}
				
				_animsByLabels[ tmpLabel ] = anim;
				_labels.push( tmpLabel );
			}
		}
		
		private function initDisplay():void
		{
			_animHolder.bitmapData = BitmapData( _animsByLabels[ _labels[ 0 ] ][ 0 ] ).clone();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function play( label:String ):void
		{
			if ( _playing ) stop();
			
			_currentLabel = label;
			_currentAnim = _animsByLabels[ _currentLabel ];
			_totalLabelFrames = _currentAnim.length;
			
			_timer.addEventListener( TimerEvent.TIMER, render, false, 0, true );
			_timer.start();
		}
		
		public function stop():void
		{
			_timer.stop();
			_timer.removeEventListener( TimerEvent.TIMER, render );
			_idx = 0;
		}
		
		public function pause():void
		{
			_timer.stop();
			_timer.removeEventListener( TimerEvent.TIMER, render );
		}
		
		public function dispose():void
		{
			_animHolder.bitmapData.dispose();
			_animHolder = null;
			
			var a:/*BitmapData*/Array;
			var n:int = _labels.length, m:int;
			for ( var i:int; i < n; ++i )
			{
				a = _animsByLabels[ _labels[ i ] ];
				m = a.length;
				while ( --m > -1 )
				{
					a[ m ].dispose();
					a[ m ] = null;
				}
				_animsByLabels[ _labels[ i ] ] = null;
				delete _animsByLabels[ _labels[ i ] ];
			}
			
			_labels = null;
			_swf = null;
		}
		
		public function isPlaying():Boolean { return _playing; }
		
		public function getCurrentIdx():int { return _idx; }
		public function getTotalFrames():int { return _totalLabelFrames; }
		public function getCurrentLabel():String { return _currentLabel; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}