
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
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Main extends MovieClip
	{
		public var cnt:MovieClip;
		public var menu:MovieClip;
		public var background:Background;
		public var contact:MovieClip;
		public var soundManager:SoundManager;
		private var linksManager:LinksManager;
		
		private var vignettesManager:VignettesManager;
		private var datas:Datas;
		private var toolTip:Tooltip;
		private var toolTips:Array;
		private var curtain:Sprite;
		private var player:Player;
		
		// Vidéo taille : 768 * 576 // 512 * 384 // 426 * 320
		
		public function Main() 
		{
			trace( "/*" );
			trace( "* Floz - Florian Zumbrunn : http://www.floz.fr" );
			trace( "* Flash developper" );
			trace( "* http://www.minuit4.fr" );
			trace( "*/" );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			background.x = -this.x;
			background.y = -this.y;
			
			vignettesManager = new VignettesManager();
			vignettesManager.addEventListener( Vignette.VIGNETTE_OVER, onVignetteOver );
			vignettesManager.addEventListener( Vignette.VIGNETTE_OUT, onVignetteOut );
			vignettesManager.addEventListener( Vignette.VIGNETTE_CLICK, onVignetteClick );
			cnt.addChild( vignettesManager );
			
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
			
			contact.zMail.addEventListener( MouseEvent.CLICK, onMailClick );
			contact.x = 960 * .5 - contact.width * .5;
			contact.y = stage.stageHeight - this.y - 25;
			
			soundManager.x = 960 * .5 + stage.stageWidth * .5 - soundManager.width;
			soundManager.y = 560 * .5 + stage.stageHeight * .5 - 50;
			
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
			curtain.x = -this.x;
			curtain.y = stage.stageHeight - this.y;
			curtain.height = 0;
			curtain.visible = true;
			curtain.scaleY = 0;
			TweenLite.to( curtain, .4, { height: stage.stageHeight, ease: Quad.easeOut } );
			
			if ( soundManager.isActivated() ) soundManager.pause();
			
			//player = new Player( Vignette( e.target ).getFLV() );
			//addChild( player );
			//player.init();
		}
		
		private function onCurtainClick(e:MouseEvent):void 
		{
			player.destroy();
			TweenLite.to( curtain, .4, { height: 0, ease: Quad.easeOut, onComplete: reactivate } );
			
			if ( soundManager.isActivated() ) soundManager.resume();
		}
		
		private function onMailClick(e:MouseEvent):void 
		{
			var request:URLRequest = new URLRequest( "mailTo:" + "bolak@free.fr" );
			try
			{
				navigateToURL( request );
			}
			catch ( e:Error )
			{
				trace ( "navigateToURL error : " + e.message );
			}
		}
		
		private function onResize(e:Event):void 
		{
			curtain.x = - this.x;
			curtain.y = stage.stageHeight - this.y;
			curtain.width = stage.stageWidth;
			
			background.x = -this.x;
			background.y = -this.y;
			
			contact.x = 960 * .5 - contact.width * .5;
			contact.y = stage.stageHeight - this.y - 25;
			
			soundManager.x = 960 * .5 + stage.stageWidth * .5 - soundManager.width;
			soundManager.y = 560 * .5 + stage.stageHeight * .5 - 50;
		}
		
		private function onRubriqueChange(e:Event):void 
		{
			if ( linksManager.numChildren ) linksManager.clear();
			
			var rubName:String = Menu( menu ).getRubriqueName();
			
			switch( rubName )
			{
				case Const.CLIP: background.changeColor( Const.CLIP_COLOR ); break;
				case Const.PUB: background.changeColor( Const.PUB_COLOR ); break;
				case Const.SHORT: background.changeColor( Const.SHORT_COLOR ); break;
				case Const.LINKS: background.changeColor( Const.LINKS_COLOR ); break;
			}
			
			if ( rubName != Const.LINKS )
			{
				vignettesManager.load( datas.getInfos( rubName ) );
				return;
			}
			
			vignettesManager.clear();
			
			linksManager.init();
		}
		
		private function onComplete(e:Event):void 
		{
			datas.removeEventListener( Event.COMPLETE, onComplete );
			
			linksManager = new LinksManager( datas.getLinks() );
			addChild( linksManager );
			
			onRubriqueChange( null );
			menu.addEventListener( Menu.RUBRIQUE_CHANGE, onRubriqueChange );
		}
		
		// PRIVATE
		
		private function reactivate():void
		{
			curtain.visible = false;
		}
		
		// PUBLIC
		
	}
	
}