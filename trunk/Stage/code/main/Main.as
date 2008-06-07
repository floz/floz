package main 
{
	import caurina.transitions.Tweener;
	import five3D.display.DynamicText3D;
	import five3D.display.Scene3D;
	import five3D.display.Sprite3D;
	import five3D.typography.HelveticaBold;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	/**
	* Page permettant de télécharger le rapport de stage.
	* @author Florian Zumbrunn
	*/
	public class Main extends MovieClip
	{
		private var fond:Sprite;
		private var scene:Scene3D;
		private var cntTxt:Sprite3D;
		
		public function Main() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener( Event.RESIZE, onResize );
			
			init();
		}
		
		private function onResize(e:Event):void 
		{
			scene.x = stage.stageWidth/2
			scene.y = stage.stageHeight / 2;
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if ( e.currentTarget.extra.axe )
			{
				e.currentTarget.extra.axe = !e.currentTarget.extra.axe;
				Tweener.addTween( e.currentTarget, { z: -200, time: 1, transition: "easeInOutQuad", onComplete: comeBack, onCompleteParams: [ e.currentTarget ] } );
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var urlRequest:URLRequest = new URLRequest( path_pdf + "rapport_florian_zumbrunn.pdf" );
			navigateToURL( urlRequest );
		}
		
		// PRIVATE
		private function init():void
		{
			scene = new Scene3D();
			scene.x = stage.stageWidth / 2;
			scene.y = stage.stageHeight / 2;
			addChild( scene );
			
			cntTxt = new Sprite3D();
			scene.addChild( cntTxt );
			
			var txt:String = "Cliquez ici pour telecharger le rapport";
			var tabString:Array = txt.split( "" );
			
			var t:DynamicText3D;
			var letterPosition:Number = 0;
			var letterWidth:Number = 0;
			
			var i:int = 0;
			var n:int = tabString.length;
			for ( i; i < n; i++ )
			{
				t = new DynamicText3D( HelveticaBold );
				t.size = 30;
				t.color = 0xffffff;
				t.text = tabString[ i ];
				t.x = letterPosition;
				
				letterWidth = HelveticaBold.__widths[ tabString[ i ] ] * ( t.size / 100 );
				letterPosition += letterWidth;
				
				cntTxt.addChild( t );
				
				t.extra = { axe: true };
				
				t.addEventListener( MouseEvent.ROLL_OVER, onOver );
			}
			var txtWidth:Number = letterPosition;
			var txtHeight:Number = HelveticaBold.__widths[ "C" ] * ( t.size / 100 );
			
			cntTxt.x = -txtWidth / 2;
			cntTxt.y = -txtHeight;
			
			var filters:Array = [ new GlowFilter( 0x88DDCB, .5, 6, 6, 2, 3 ) ];
			cntTxt.filters = filters;
			
			cntTxt.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function comeBack( t:DynamicText3D ):void
		{
			Tweener.addTween( t, { z: 0, time: 1, transition: "easeInOutQuad", onComplete: function():void { t.extra.axe = !t.extra.axe } } );
		}
		
		// PUBLIC
		public function get path_pdf():String
		{
			return loaderInfo.parameters[ "path_pdf"] || "ressources/";
		}
		
	}
	
}