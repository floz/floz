
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		public var cnt:MovieClip;
		public var menu:MovieClip;
		
		private var vignettesManager:VignettesManager;
		private var datas:Datas;
		
		public function Main() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			vignettesManager = new VignettesManager();
			addChild( vignettesManager );
			
			menu.addEventListener( Menu.RUBRIQUE_CHANGE, onRubriqueChange );
			
			datas = new Datas( "xml/" + "datas.xml" );
			datas.addEventListener( Event.COMPLETE, onComplete );
			datas.load();
		}
		
		private function onRubriqueChange(e:Event):void 
		{
			vignettesManager.load( datas.getInfos( Menu( menu ).getRubriqueName() ) );
		}
		
		private function onComplete(e:Event):void 
		{
			datas.removeEventListener( Event.COMPLETE, onComplete );
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}