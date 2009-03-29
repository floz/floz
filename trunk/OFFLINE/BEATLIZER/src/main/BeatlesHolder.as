
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.utils.UBit;
	
	public class BeatlesHolder extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _index:int;
		
		private var _mask:BitmapData;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var z:SimpleButton;
		public var cnt:MovieClip;
		public var strk:MovieClip;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function BeatlesHolder( index:int ) 
		{
			_index = index;
			strk.visible = false;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );	
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setMask( bd:BitmapData ):void
		{
			_mask = bd;
			
			var b:Bitmap = new Bitmap( UBit.resize( bd, strk.width, strk.height, true ), PixelSnapping.AUTO, true );
			cnt.addChild( b );
		}
		
		public function getMask():BitmapData
		{
			return _mask;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get index():int { return _index; }
		
	}
	
}