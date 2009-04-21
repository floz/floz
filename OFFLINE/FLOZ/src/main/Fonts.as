
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.system.ApplicationDomain;
	import fr.minuit4.tools.loaders.types.MovieLoader;
	
	public class Fonts extends MovieLoader
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _fonts:AssetsFonts;
		
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
			_fonts = new AssetsFonts( a );
			
			super.setItemLoaded();			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		final override public function getItemLoaded():* { return _fonts; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}
import flash.system.ApplicationDomain;
import flash.text.Font;

class AssetsFonts
{
	public var futuraLight:Font;
	public var futuraMedium:Font;
	
	public function AssetsFonts( domain:ApplicationDomain )
	{
		futuraLight = new( Class( domain.getDefinition( "FuturaLight" ) ) );
		futuraMedium = new( Class( domain.getDefinition( "FuturaMedium" ) ) );
	}
}