
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import elive.xmls.EliveXML;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.net.loaders.types.DatasLoader;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{			
			var url:String = "xml/action_sheet.xml";
			var datasLoader:DatasLoader = new DatasLoader( url );
			datasLoader.addEventListener( Event.COMPLETE, handleLoadComplete );
			datasLoader.load();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function handleLoadComplete(e:Event):void 
		{
			var datasLoader:DatasLoader = e.currentTarget as DatasLoader;
			var datas:String = datasLoader.getItemLoaded();
			trace( EliveXML.parseComments( XML( datas ), true )[ 0 ].getUser() );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}