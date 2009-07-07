
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import caurina.transitions.Tweener;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import fr.minuit4.motion.easing.Linear;
	import fr.minuit4.motion.easing.Quad;
	import fr.minuit4.motion.M4TweenInfos;
	import gs.TweenLite;
	
	public class HowItWorks extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _startTime:int;
		private var _completeTime:int;
		private var _mov1:Sprite;
		private var _mov2:Sprite;
		private var _mov3:Sprite;
		private var _currentTime:int;
		
		private var _tweens:Array;
		private var _bt:Sprite;
		private var _bt2:Sprite;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function HowItWorks() 
		{
			_mov1 = createSprite();
			_mov1.y = stage.stageHeight * .5 - 200;
			addChild( _mov1 );
			
			_mov2 = createSprite();
			_mov2.y = stage.stageHeight * .5 + 200;
			_mov2.x = 500;
			addChild( _mov2 );
			
			_mov3 = createSprite();
			_mov3.y = stage.stageHeight * .5;
			addChild( _mov3 );
			
			_bt = createBt();
			_bt.x =
			_bt.y = 10;
			addChild( _bt );
			_bt.addEventListener( MouseEvent.CLICK, onClick );
			
			_bt2 = createBt();
			_bt2.x = 10
			_bt2.y = 100;
			addChild( _bt2 );
			_bt2.addEventListener( MouseEvent.CLICK, onClick );
			
			_tweens = [];
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onClick(e:MouseEvent):void 
		{
			if ( e.currentTarget == _bt )
			{
				_mov1.x = 0;
				TweenLite.to( _mov1, 5, { x: 500, ease: Quad.easeOut } );
				
				_mov3.x = 0;
				Tweener.addTween( _mov3, { x: 500, time: .5, transition: "easeoutquad" } );
				
				_mov2.x = 0;
				var ti:M4TweenInfos = new M4TweenInfos( "x", 0, 500, 5 );
				ti.startTime = _currentTime;
				_tweens.push( ti );
			}
			else
			{
				_mov1.x = 200;
				_mov2.x = 200;
			}
		}
		
		private function onFrame(e:Event):void 
		{
			if ( !_startTime ) 
			{
				_startTime = getTimer();
				_completeTime = _startTime + 1000;
			}
			_currentTime = getTimer();
			updateTweens();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function createSprite():Sprite
		{
			var s:Sprite = new Sprite();			
			var g:Graphics = s.graphics;
			g.beginFill( 0xff00ff );
			g.drawCircle( 0, 0, 20 );
			g.endFill();
			
			return s;
		}
		
		private function createBt():Sprite
		{
			var s:Sprite = new Sprite();			
			var g:Graphics = s.graphics;
			g.beginFill( 0x00ffff );
			g.drawRect( 0, 0, 100, 30 );
			g.endFill();
			
			return s;
		}
		
		private function updateTweens():void
		{
			var value:Number;
			var ti:M4TweenInfos;
			var i:int = _tweens.length;
			while ( --i > -1 )
			{
				ti = _tweens[ i ];
				//if ( !ti.active )
				//{
					//ti.startTime = _currentTime;
					//value = Quad.easeOut( 0, ti.startValue, ti.endValue, ti.duration * 1000 );
					//_mov2[ ti.property ] = ti.startValue + value;
					//ti.active = true;
				//}
				if (!ti.complete )
				{
					value = Quad.easeOut( _currentTime - ti.startTime, ti.startValue, ti.endValue - ti.startValue, ti.duration * 1000 );
					trace( "value : " + value );
					if ( _currentTime < ti.startTime + ti.duration * 1000 )
					{
						_mov2[ ti.property ] = value;
					}
					else
					{
						_mov2[ ti.property ] = ti.endValue;
						ti.complete = true;
					}
				}
				else
				{
					//trace( "finis !" );
				}
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}