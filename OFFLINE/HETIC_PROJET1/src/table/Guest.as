
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Guest extends MovieClip
	{
		//public static const ETRANGER:String = "etranger";
		public static const CULTIVE:String = "cultive";
		public static const HUMOURGRAS:String = "humourgras";
		public static const DECALE:String = "decale";
		public static const INCLASSABLE:String = "inclassable";
		
		public var cnt:MovieClip;
		
		//private var defined:Boolean;
		
		private var bPortrait:Bitmap;
		
		public function Guest( bPortrait:Bitmap = null ) 
		{
			this.bPortrait = bPortrait;
			
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
			
			cnt.addChild( bPortrait ? bPortrait : new Bitmap( new Default( 0, 0 ) ) );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function choose( m:MovieClip ):void
		{
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			
			cnt.addChild( m );
			
			//defined = true;
		}
		
	}
	
}