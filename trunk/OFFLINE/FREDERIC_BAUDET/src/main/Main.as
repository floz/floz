
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		public var cnt:MovieClip;
		public var menu:MovieClip;
		public var background:MovieClip;
		
		private var vignettesManager:VignettesManager;
		private var datas:Datas;
		private var toolTip:Tooltip
		private var toolTips:Array;
		
		// Vidéo taille : 768 * 576 // 512 * 384 // 426 * 320
		
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
			vignettesManager.addEventListener( Vignette.VIGNETTE_OVER, onVignetteOver );
			vignettesManager.addEventListener( Vignette.VIGNETTE_OUT, onVignetteOut );
			cnt.addChild( vignettesManager );
			
			menu.addEventListener( Menu.RUBRIQUE_CHANGE, onRubriqueChange );
			
			toolTips = [];
			
			datas = new Datas( "xml/" + "datas.xml" );
			datas.addEventListener( Event.COMPLETE, onComplete );
			datas.load();
		}
		
		private function onVignetteOver(e:Event):void 
		{
			toolTip = new Tooltip();
			addChild( toolTip );
			
			toolTips.push( toolTip );
			
			toolTip.activate( e.target as DisplayObject, Vignette( e.target ).getTitle(), Vignette( e.target ).getDirector(), Vignette( e.target ).getSound() );
		}
		
		private function onVignetteOut(e:Event):void 
		{
			if ( toolTips.length ) Tooltip( toolTips.shift() ).desactivate();		
		}
		
		private function onRubriqueChange(e:Event):void 
		{
			vignettesManager.load( datas.getInfos( Menu( menu ).getRubriqueName() ) );
		}
		
		private function onComplete(e:Event):void 
		{
			datas.removeEventListener( Event.COMPLETE, onComplete );
			
			onRubriqueChange( null );
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}