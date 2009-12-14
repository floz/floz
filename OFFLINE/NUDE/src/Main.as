
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import com.nude.data.DynamicDatas;
	import com.nude.data.parsers.XMLParser;
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
			var datasLoader:DatasLoader = new DatasLoader( "xml/datas.xml" );
			datasLoader.addEventListener( Event.COMPLETE, completeHandler );
			datasLoader.load();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function completeHandler(e:Event):void 
		{
			var s:String = DatasLoader( e.currentTarget ).getItemLoaded();
			
			var datas:XML = XML( s );
			
			var d:DynamicDatas = new DynamicDatas();
			d.setParser( new XMLParser( datas ) );
			d.parseDatas();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}