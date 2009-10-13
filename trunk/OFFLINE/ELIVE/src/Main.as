﻿
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
	import fr.minuit4.net.loaders.types.DataLoader;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			var url:String = "xml/friends_list.xml";
			var datasLoader:DataLoader = new DataLoader( url );
			datasLoader.addEventListener( Event.COMPLETE, handleLoadComplete );
			datasLoader.load();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function handleLoadComplete(e:Event):void 
		{
			var datasLoader:DataLoader = e.currentTarget as DataLoader;
			var data:String = datasLoader.getItemLoaded();
			EliveXML.parseUsers( XML( data ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}