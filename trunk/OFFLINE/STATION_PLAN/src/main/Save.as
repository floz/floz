
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import gs.easing.Linear;
	import gs.TweenLite;
	
	public class Main extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cnt:Sprite;
		private var _map:Bitmap;
		
		private var _zoomed:Boolean;
		private var _running:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_cnt = new Sprite();
			
			_map = new Bitmap( new Map( 0, 0 ), PixelSnapping.AUTO, true );
			_map.x = -_map.width * .5;
			_map.y = -_map.height * .5;
			_cnt.addChild( _map );
			
			_cnt.x = stage.stageWidth * .5;
			_cnt.y = stage.stageHeight * .5;
			addChild( _cnt );
			
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onClick(e:MouseEvent):void 
		{
			if ( _running ) 
				return;
			
			if ( !_zoomed )
			{
				trace( e.localX );
				trace( e.localY );
				TweenLite.to( _cnt, .5, { x: _cnt.x - e.localX * 4, y: _cnt.y - e.localY * 4, scaleX: 4, scaleY: 4, ease: Linear.easeIn, onComplete: onTweenComplete } );
			}
			else
			{
				TweenLite.to( _cnt, .5, { x: stage.stageWidth * .5, y: stage.stageHeight * .5, scaleX:1, scaleY: 1, ease: Linear.easeIn, onComplete: onTweenComplete } );
			}
			_running = true;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function onTweenComplete():void
		{
			_running = false;
			_zoomed = !_zoomed;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}