
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
			var assetsFonts:AssetsFonts = new AssetsFonts( a );
			
			Font.registerFont( assetsFonts.futuraLight );
			Font.registerFont( assetsFonts.futuraMedium );
			
			super.setItemLoaded();			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}
import flash.system.ApplicationDomain;
import flash.text.Font;

class AssetsFonts
{
	public var futuraLight:Class;
	public var futuraMedium:Class;
	
	public function AssetsFonts( domain:ApplicationDomain )
	{
		futuraLight = domain.getDefinition( "FLight" ) as Class;
		futuraMedium = domain.getDefinition( "FMedium" ) as Class;
	}
}