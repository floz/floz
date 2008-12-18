
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
	import flash.geom.Matrix;
	import fr.minuit4.utils.UBit;
	import portrait.bmpd.Separation;
	
	public class Vignette extends MovieClip
	{
		public static const VIGNETTE_SELECTED:String = "vignette_selected";
		
		public var z:SimpleButton;
		
		private var small:Boolean;
		private var bitmapData:BitmapData;
		private var event:Event;
		
		public function Vignette( small:Boolean, bitmapData:BitmapData ) 
		{
			this.small = small;
			this.bitmapData = bitmapData;
			
			event = new Event( Vignette.VIGNETTE_SELECTED );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			z.removeEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			var b:Bitmap = new Bitmap( small ? UBit.resize( bitmapData, 180, 80, true, true ) : UBit.resize( bitmapData, 180, 180, true, true ) );
			
			var b2:Bitmap = new Bitmap( new BitmapData( 180, small ? 90 : 190, true, 0x000000 ) );
			b2.bitmapData.draw( b, new Matrix( 1, 0, 0, 1, 0, small ? 5 : 10 ) );
			var separation:BitmapData = new Separation();
			b2.bitmapData.draw( separation, new Matrix( 1, 0, 0, 1, 12 ) );
			//b2.bitmapData.draw( separation, new Matrix( 1, 0, 0, 1, 12, b.height - separation.height ) );			
			addChild( b2 );
			
			z.width = b.width;
			z.height = b.height;
			
			z.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			dispatchEvent( event );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function getBitmapData():BitmapData
		{
			return bitmapData;
		}
		
	}
	
}