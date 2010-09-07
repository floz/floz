
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package test_loaders 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import fr.minuit4.core.commands.events.CommandEvent;
	import fr.minuit4.core.commands.Executer;
	import fr.minuit4.debug.FPS;
	import fr.minuit4.net.loaders.AssetLoader;
	import fr.minuit4.net.loaders.DataLoader;
	
	public class MainExecuter extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cnt:Sprite;
		private var _executer:Executer;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainExecuter() 
		{
			addChild( _cnt = new Sprite() );
			
			var executer:Executer = new Executer();
			executer.addCommand( new AssetLoader( "assets/images/dragon.jpg" ), "dragon_2" );
			executer.addCommand( new AssetLoader( "assets/images/grappin.jpg" ), "grappin_2" );
			
			_executer = new Executer();
			_executer.addCommand( executer, "paquet" );
			_executer.addCommand( new AssetLoader( "assets/images/dragon.jpg" ), "dragon" );
			_executer.addCommand( new AssetLoader( "assets/images/grappin.jpg" ) );
			_executer.addCommand( new DataLoader( "assets/css/style.css" ) );
			_executer.addEventListener( CommandEvent.PROGRESS, progressHandler, false, 0, true );
			_executer.addEventListener( CommandEvent.COMMAND_COMPLETE, commandCompleteHandler, false, 0, true );
			_executer.addEventListener( CommandEvent.COMPLETE, completeHandler, false, 0, true );
			_executer.execute();
			
			addChild( new FPS() );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function progressHandler(e:CommandEvent):void 
		{
			trace( "PROGRESS !" );
			trace( "PROGRESS >> progressCount : " + e.progressCount + ", totalCount : " + e.totalCount );
			trace( "PROGRESS >> percent : " + e.progressCount / e.totalCount );
		}
		
		private function commandCompleteHandler(e:CommandEvent):void 
		{
			trace( "COMMAND COMPLETE !" );
			if ( _executer.currentCommand is AssetLoader )
			{
				var assetLoader:AssetLoader = _executer.currentCommand as AssetLoader;
				_cnt.addChild( assetLoader.content );
			}
			else if ( _executer.currentCommand is DataLoader )
			{
				var dataLoader:DataLoader = _executer.currentCommand as DataLoader;
				trace( dataLoader.content );
			}
		}
		
		private function completeHandler(e:CommandEvent):void 
		{
			trace( "FINIS !" );
			var executer:Executer = _executer.getCommandById( "paquet" ) as Executer;
			var grappin:Bitmap = AssetLoader( executer.getCommandById( "grappin_2" ) ).content as Bitmap;
			grappin.x = grappin.y = 200;
			addChild( grappin );
			
			// OK
			trace( executer );
			trace( executer.getCommandById( "grappin_2" ) );
			
			_executer.removeEventListener( CommandEvent.PROGRESS, progressHandler );
			_executer.removeEventListener( CommandEvent.COMMAND_COMPLETE, commandCompleteHandler );
			_executer.removeEventListener( CommandEvent.COMPLETE, completeHandler );
			_executer.dispose();
			
			// Ca marche quelques instants, mais plus après.
			// Le temps que le garbage collector passe quoi.
			// Donc à ne pas faire : si on dispose l'object Executer principal, tout ce qu'il contient se dispose aussi.
			// Donc les autres Executer qu'il peut contenir, aussi ;)
			//trace( executer );
			//trace( executer.getCommandById( "grappin_2" ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}