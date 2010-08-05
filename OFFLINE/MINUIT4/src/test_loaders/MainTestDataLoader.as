
/**
 * @author Floz
 */
package test_loaders 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.net.loaders.DataLoader;

	public class MainTestDataLoader extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainTestDataLoader() 
		{
			var dataLoader:DataLoader = new DataLoader();
			dataLoader.addEventListener( Event.COMPLETE, completeHandler, false, 0, true );
			dataLoader.load( "assets/xml/loadme.xml" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function completeHandler(e:Event):void 
		{
			var dataLoader:DataLoader = e.currentTarget as DataLoader;
			trace( "content : " + dataLoader.content );
			dataLoader.removeEventListener( Event.COMPLETE, completeHandler );
			dataLoader.dispose();			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}