
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
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.utils.UBit;
	
	public class Vignette extends MovieClip
	{
		public var z:SimpleButton;
		
		private var small:Boolean;
		private var bitmapData:BitmapData;
		
		public function Vignette( small:Boolean, bitmapData:BitmapData ) 
		{
			this.small = small;
			this.bitmapData = bitmapData;
			
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
			
			var b:Bitmap = new Bitmap( small ? UBit.resize( bitmapData, 180, 80, true, true ) : UBit.resize( bitmapData, 180, 180, true, true ) );
			addChild( b );
			
			z.width = b.width;
			z.height = b.height;
			
			z.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			trace( "Vignette.onClick > e : " + e );			
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function getBitmapData():BitmapData
		{
			return bitmapData;
		}
		
	}
	
}