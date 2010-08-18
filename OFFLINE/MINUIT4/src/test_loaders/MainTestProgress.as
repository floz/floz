
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package test_loaders 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import fr.minuit4.core.commands.events.CommandEvent;
	import fr.minuit4.net.loaders.AssetLoader;
	
	public class MainTestProgress extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainTestProgress() 
		{
			var assetLoader:AssetLoader = new AssetLoader( "assets/images/dragon.jpg" );
			assetLoader.addEventListener( ProgressEvent.PROGRESS, progressHandler, false, 0, true );
			assetLoader.addEventListener( CommandEvent.PROGRESS, progressCommentHandler, false, 0, true );
			assetLoader.addEventListener( Event.COMPLETE, completeHandler, false, 0, true );
			assetLoader.load();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function progressHandler(e:ProgressEvent):void 
		{
			trace( "ProgressEvent : " + ( e.bytesLoaded / e.bytesTotal ) );
		}
		
		private function progressCommentHandler(e:CommandEvent):void 
		{
			trace( "ProgressCommandEvent" );
			trace( e.progressCount );
			trace( e.totalCount );
		}
		
		private function completeHandler(e:Event):void 
		{
			trace( "complete !" );
			addChild( AssetLoader( e.currentTarget ).content );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}