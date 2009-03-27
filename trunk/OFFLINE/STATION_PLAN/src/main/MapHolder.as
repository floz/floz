
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
	import flash.geom.ColorTransform;
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
		private var _cntPuces:Sprite;
		
		private var _puce:Puce;
		private var _colorTransform:ColorTransform;
		
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
			
			_cntPuces = new Sprite();
			cnt.addChild( _cntPuces );
			
			TweenLite.to( cnt, .4, { alpha: 1, ease: Quad.easeOut } );
			
			mapZoom.activate();
		}
		
		public function zoom():void
		{
			if ( mapZoom.display ) mapZoom.hide();
			
			while ( _cntPuces.numChildren ) _cntPuces.removeChildAt( 0 );
			
			_colorTransform = new ColorTransform();
			_colorTransform.color = Model.colors[ Model.currentListIndex ];
			
			_puce = new Puce();
			_puce.x = Model.currentItem.coordX * .5;
			_puce.y = Model.currentItem.coordY * .5;
			_puce.transform.colorTransform = _colorTransform;
			_cntPuces.addChild( _puce );
			
			if ( _timer.running ) _timer.reset();
			_timer.start();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}