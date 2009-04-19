
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import accueil.Accueil;
	import commun.Loading;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import portrait.Portrait;
	
	public class Main extends MovieClip 
	{
		public static const STEP_COMPLETE:String = "step_complete";
		
		public var cnt:MovieClip;
		public var bottom:MovieClip;
		public var top:MovieClip;
		
		private var swfLoader:SWFLoader;
		private var request:URLRequest;
		
		private var acc:Accueil;
		private var por:Portrait;
		private var tab:MovieClip;
		
		private var loading:Loading;
		
		private var step:int;		
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage.addEventListener( Event.RESIZE, onResize );
			
			loading = new Loading( 0xffffff, 8, 6 );
			addChild( loading );
			loading.x = ( stage.stageWidth >> 1 ) - 36;
			loading.y = ( stage.stageHeight >> 1 ) - 36;
			loading.play();
			
			onResize( null );
			
			swfLoader = new SWFLoader();
			swfLoader.addEventListener( Event.COMPLETE, onAccueilComplete );
			swfLoader.add( SWFs.ACCUEIL, "accueil" );
			swfLoader.loadNext();
			
			request = new URLRequest();
			
			//top.visible = false;
			
			top.zValid.addEventListener( MouseEvent.CLICK, onClick );
			top.texte.addEventListener( FocusEvent.FOCUS_IN, onFocus );
			bottom.zLogo.addEventListener( MouseEvent.CLICK, onClick );
			bottom.zLink.addEventListener( MouseEvent.CLICK, onClick );
			
			cnt.addEventListener( Main.STEP_COMPLETE, onStepComplete, true );
		}
		
		// EVENTS
		
		private function onResize(e:Event):void 
		{
			cnt.x = ( stage.stageWidth >> 1 ) - ( 980 >> 1 );
			cnt.y = ( stage.stageHeight >> 1 ) - ( 560 >> 1 );
			
			top.x = 0;
			top.y = 0;
			
			loading.x = ( stage.stageWidth >> 1 ) - 36;
			loading.y = ( stage.stageHeight >> 1 ) - 36;
				
			bottom.x = ( stage.stageWidth >> 1 ) - ( bottom.width >> 1 );
			bottom.y = stage.stageHeight - bottom.height - 5;
		}
		
		private function onAccueilComplete(e:Event):void 
		{
			loading.stop();
			top.visible = true;
			top.texte.text = "Faire connaître le site à un ami";
			top.fondImage.gotoAndStop( 1 );
			
			acc = swfLoader.getLastItem() as Accueil;
			swfLoader.reset();
			swfLoader.removeEventListener( Event.COMPLETE, onAccueilComplete );
			
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			cnt.addChild( acc );
			onResize( null );
			
			step = 1;
		}
		
		private function onStepComplete(e:Event):void 
		{
			loading.play();
			
			switch( step )
			{
				case 1: load( SWFs.PORTRAIT ); break;
				case 2: load( SWFs.TABLE ); break;
				case 3: load( SWFs.ACCUEIL ); break;
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case top.zValid: sendMail(); break;
				case bottom.zLogo: loadURL( "http://www.diaphana.fr/index.php" ); break;
				case bottom.zLink: loadURL( "http://www.ledinerdesillustres-lefilm.com" ); break;
			}
		}
		
		private function onFocus(e:FocusEvent):void
		{
			if ( top.texte.text == "Faire connaître le site à un ami" ) top.texte.text = "";
		}
		
		private function onPortraitComplete(e:Event):void 
		{
			loading.stop();
			top.visible = false;
			
			por = swfLoader.getLastItem() as Portrait;
			swfLoader.reset();
			swfLoader.removeEventListener( Event.COMPLETE, onPortraitComplete );
			
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			cnt.addChild( por );
			onResize( null );
			
			step = 2;
		}
		
		private function onTableComplete(e:Event):void 
		{
			loading.stop();
			
			tab = swfLoader.getLastItem() as MovieClip;
			swfLoader.reset();
			swfLoader.removeEventListener( Event.COMPLETE, onTableComplete );
			
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			cnt.addChild( tab );
			onResize( null );
			
			step = 3;
		}
		
		// PRIVATE
		
		private function loadURL( url:String ):void
		{
			request.url = url;
			navigateToURL( request );
		}
		
		private function load( url:String ):void
		{
			switch ( url )
			{
				case SWFs.PORTRAIT:	swfLoader.addEventListener( Event.COMPLETE, onPortraitComplete ); break;
				case SWFs.TABLE: swfLoader.addEventListener( Event.COMPLETE, onTableComplete ); break;
				case SWFs.ACCUEIL: swfLoader.addEventListener( Event.COMPLETE, onAccueilComplete ); break;
			}
			
			swfLoader.add( url, "temp" );
			swfLoader.load();
		}
		
		private function sendMail():void
		{
			if ( isTextIsMail() ) 
			{
				top.texte.text = "Faire connaître le site à un ami";
				top.fondImage.gotoAndStop( 1 );
			}
			else
			{
				top.fondImage.gotoAndStop( 2 );
			}			
		}
		
		private function isTextIsMail():Boolean
		{
			var s:String = top.texte.text;
			if ( !s || s == " " ) return false;
			
			var i:int = s.search( /[@]/g );
			if ( i < 0 ) return false;
			
			i = s.search( /[.]/g );
			if ( i < 0 ) return false;
			
			return true;
		}
		
		// PUBLIC
		
		public function getPortraitInfos():Object
		{
			return por.getPortraitInfos();
		}
		
		public function getX():Number { return cnt.x };
		public function getY():Number { return cnt.y };
		
		public function get path_swf():String { return loaderInfo.parameters["path_flv"] || ""; }
		public function get path_xml():String { return loaderInfo.parameters["path_xml"] || "xml/"; }
		public function get path_php():String { return loaderInfo.parameters["path_php"] || "php/"; }
	}
	
}