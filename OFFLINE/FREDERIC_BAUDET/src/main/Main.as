
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import fl.video.VideoPlayer;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Main extends MovieClip
	{
		public var cnt:MovieClip;
		public var menu:MovieClip;
		public var background:Background;
		
		private var vignettesManager:VignettesManager;
		private var datas:Datas;
		private var toolTip:Tooltip
		private var toolTips:Array;
		private var curtain:Sprite;
		private var player:Player;
		
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
			vignettesManager.addEventListener( Vignette.VIGNETTE_CLICK, onVignetteClick );
			cnt.addChild( vignettesManager );
			
			menu.addEventListener( Menu.RUBRIQUE_CHANGE, onRubriqueChange );
			
			toolTips = [];
			
			curtain = new Sprite();
			var g:Graphics = curtain.graphics;
			g.beginFill( 0x000000, .6 );
			g.drawRect( 0, -stage.stageHeight, stage.stageWidth, stage.stageHeight );
			g.endFill();
			
			curtain.visible = false;
			curtain.buttonMode = true;
			curtain.useHandCursor = true;
			curtain.addEventListener( MouseEvent.CLICK, onCurtainClick );
			addChild( curtain );
			
			stage.addEventListener( Event.RESIZE, onResize );
			
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
		
		private function onVignetteClick(e:Event):void 
		{
			curtain.y = stage.stageHeight;
			curtain.visible = true;
			curtain.scaleY = 0;
			Tweener.addTween( curtain, { scaleY: 1, time: .4, transition: "easeOutQuad" } );
			
			player = new Player( Vignette( e.target ).getFLV() );
			addChild( player );
			player.init();
		}
		
		private function onCurtainClick(e:MouseEvent):void 
		{
			player.destroy();
			Tweener.addTween( curtain, { scaleY: 0, time: .4, transition: "easeOutQuad", onComplete: reactivate } );
		}
		
		private function onResize(e:Event):void 
		{
			curtain.width = stage.stageWidth;
			curtain.height = stage.stageHeight;
		}
		
		private function onRubriqueChange(e:Event):void 
		{
			var rubName:String = Menu( menu ).getRubriqueName();
			vignettesManager.load( datas.getInfos( rubName ) );
			
			switch( rubName )
			{
				case Const.CLIP: background.changeColor( Const.CLIP_COLOR ); break;
				case Const.PUB: background.changeColor( Const.PUB_COLOR ); break;
				case Const.SHORT: background.changeColor( Const.SHORT_COLOR ); break;
			}
		}
		
		private function onComplete(e:Event):void 
		{
			datas.removeEventListener( Event.COMPLETE, onComplete );
			
			onRubriqueChange( null );
		}
		
		// PRIVATE
		
		private function reactivate():void
		{
			curtain.visible = false;
		}
		
		// PUBLIC
		
	}
	
}