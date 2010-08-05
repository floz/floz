
/**
 * @author Floz
 */
package test_loaders 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.net.loaders.AssetLoader;

	public class MainTestAssetLoader extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _assetLoader:AssetLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainTestAssetLoader() 
		{
			_assetLoader = new AssetLoader();
			_assetLoader.addEventListener( Event.COMPLETE, completeHandler, false, 0, true );
			_assetLoader.load( "assets/images/dragon.jpg" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function completeHandler(e:Event):void 
		{
			_assetLoader.removeEventListener( Event.COMPLETE, completeHandler );
			
			var b:Bitmap = _assetLoader.content as Bitmap;
			addChild( b );
			
			_assetLoader.dispose();
			_assetLoader = null;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}