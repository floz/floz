
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import fr.minuit4.utils.UBit;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class MapHolder extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _smallMap:Bitmap;
		private var _zoomMap:Bitmap;
		private var _timer:Timer;
		
		private var _zoomed:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:Sprite;
		public var mapZoom:MapZoomHolder;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MapHolder() 
		{
			mapZoom.visible = false;
			
			cnt.alpha = 0;
			
			_timer = new Timer( 1200, 1 );
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			mapZoom.zoom();
			_zoomed = true;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			_smallMap = new Bitmap( UBit.resize( Model.map, 730, 259, true ), PixelSnapping.AUTO, true );
			_smallMap.x = -_smallMap.width * .5;
			_smallMap.y = -_smallMap.height * .5;
			cnt.addChild( _smallMap );
			cnt.x = -_smallMap.x;
			cnt.y = -_smallMap.y * 1.5;
			
			TweenLite.to( cnt, .4, { alpha: 1, ease: Quad.easeOut } );
			
			mapZoom.activate();
		}
		
		public function zoom():void
		{
			if ( mapZoom.display ) mapZoom.hide();
			
			var p:MovieClip = new Puce();
			p.x = Model.currentItem.coordX * .5;
			p.y = Model.currentItem.coordY * .5;
			cnt.addChild( p );
			_timer.start();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}