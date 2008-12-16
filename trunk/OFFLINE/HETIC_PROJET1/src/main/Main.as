
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
	import portrait.Portrait;
	
	public class Main extends MovieClip 
	{
		public static const STEP_COMPLETE:String = "step_complete";
		
		public var cnt:MovieClip;
		
		private var swfLoader:SWFLoader;
		
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
			
			loading = new Loading( 0xffffff, 5, 6 );
			addChild( loading );
			loading.x = ( stage.stageWidth >> 1 ) - 30;
			loading.y = ( stage.stageHeight >> 1 ) - 30;
			loading.play();
			
			swfLoader = new SWFLoader();
			swfLoader.addEventListener( Event.COMPLETE, onAccueilComplete );
			swfLoader.add( SWFs.ACCUEIL, "accueil" );
			swfLoader.loadNext();
			
			cnt.addEventListener( Main.STEP_COMPLETE, onStepComplete, true );
		}
		
		// EVENTS
		
		private function onResize(e:Event):void 
		{
			cnt.x = ( stage.stageWidth >> 1 ) - ( cnt.width >> 1 );
			cnt.y = ( stage.stageHeight >> 1 ) - ( cnt.height >> 1 );
		}
		
		private function onAccueilComplete(e:Event):void 
		{
			loading.stop();
			
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
		
		private function onPortraitComplete(e:Event):void 
		{
			loading.stop();
			
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
		
		//private function backToAccueil():void
		//{
			//while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			//cnt.addChild( acc );
			//onResize( null );
			//
			//step = 1;
		//}
		
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
		
		// PUBLIC
		
		public function getPortraitInfos():Object
		{
			return por.getPortraitInfos();
		}
		
		public function getX():Number { return cnt.x };
		public function getY():Number { return cnt.y };
		
	}
	
}