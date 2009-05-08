﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package assets 
{
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	import fr.minuit4.net.loaders.types.MovieLoader;
	
	public class Fonts extends MovieLoader
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Fonts() 
		{
			super( false );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		final override protected function setItemLoaded():void 
		{
			var a:ApplicationDomain = _loader.contentLoaderInfo.applicationDomain;
			
			var futuraLight:Class = a.getDefinition( "FuturaLight" ) as Class;
			var futuraMedium:Class = a.getDefinition( "FuturaMedium" ) as Class;
			Font.registerFont( futuraLight );
			Font.registerFont( futuraMedium );
			
			super.setItemLoaded();			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}