
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Interface extends MovieClip
	{
		public var cnt:MovieClip;
		
		private var bitmap:Bitmap;
		
		public function Interface() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function clean():void
		{
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
		}
		
		public function saveAsBitmap():void
		{
			var bd:BitmapData = new BitmapData( cnt.width, cnt.height, true, 0xff00ff );
			bd.draw( cnt );
			
			bitmap = new Bitmap( bd );
		}
		
		// GETTERS & SETTERS
		
		public function getBitmap():Bitmap
		{
			return bitmap;
		}
		
	}
	
}