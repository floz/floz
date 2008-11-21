
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Main extends MovieClip
	{
		public static const READY:String = "ready";
		
		public static const WORKS:String = "works";
		public static const ARCHIVES:String = "archives";
		public static const CONTACT:String = "contact";
		
		public var section:String = WORKS;
		
		public var screen:Screen;
		public var listeVignettes:ListeVignettes;
		public var menu:Menu;
		
		private var datas:Datas;
		
		public var works:Array; // [ { name, preview, film }, { name, preview, film }, ... } ]
		public var archives:Array; // [ { name, preview, film }, { name, preview, film }, ... } ]
		public var contact:Object; // { mail, skype, tel }
		private var cloud:Sprite;
		
		public function Main() 
		{
			datas = new Datas( "xml/projets.xml" );
			datas.load();
			
			datas.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete(e:Event):void 
		{			
			this.works = datas.getInfos( WORKS );
			this.archives = datas.getInfos( ARCHIVES );
			this.contact = datas.getContactInfos();
			
			cloud = new Sprite();
			var g:Graphics = cloud.graphics;
			g.beginFill( 0xff000000 );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			
			cloud.alpha = 0;
			cloud.visible = false;
			cloud.buttonMode = true;
			
			addChild( cloud );
			setChildIndex( screen, getChildIndex( cloud ) );
			
			dispatchEvent( new Event( Main.READY ) );
			
			listeVignettes.addEventListener( Vignette.VIGNETTE_OVER, onVignetteOver );
			listeVignettes.addEventListener( Vignette.VIGNETTE_OUT, onVignetteOut );
			listeVignettes.addEventListener( Vignette.VIGNETTE_PRESS, onVignettePress );
			
			screen.addEventListener( Event.INIT, onVideoInit );
		}
		
		// EVENTS
		
		private function onVignetteOver(e:Event):void 
		{
			screen.display( getPathImages() + e.target.preview );
		}
		
		private function onVignetteOut(e:Event):void 
		{
			screen.clear();
		}
		
		private function onVignettePress(e:Event):void 
		{
			screen.select( getPathFLV() + e.target.film );		
		}
		
		private function onVideoInit(e:Event):void 
		{
			cloud.visible = true;
			cloud.alpha = .2;
			Tweener.addTween( cloud, { alpha: .6, time: .8, transition: "easeInOutQuad" } );
			
			cloud.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			screen.close();
			Tweener.addTween( cloud, { alpha: 0,  time: .5, transition: "easeInOutquad", onComplete: reset } );
			
			cloud.removeEventListener( MouseEvent.CLICK, onClick );
		}
		
		// PRIVATE
		
		private function reset():void
		{
			cloud.visible = false;
			Tweener.removeTweens( cloud );
		}
		
		// PUBLIC
		
		public function getPathImages():String { return "images/" };
		
		public function getPathFLV():String { return "flv/" };
		
	}
	
}