
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import accueil.Accueil;
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
		
		private var step:int;
		
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage.addEventListener( Event.RESIZE, onResize );
			
			swfLoader = new SWFLoader();
			swfLoader.addEventListener( Event.COMPLETE, onAccueilComplete );
			swfLoader.add( SWFs.ACCUEIL, "accueil" );
			swfLoader.loadNext();
			
			cnt.addEventListener( Main.STEP_COMPLETE, onStepComplete, true );
			//cnt.addEventListener( Portrait.STEP_COMPLETE, onStepComplete, true );
		}
		
		// EVENTS
		
		private function onResize(e:Event):void 
		{
			cnt.x = ( stage.stageWidth >> 1 ) - ( cnt.width >> 1 );
			cnt.y = ( stage.stageHeight >> 1 ) - ( cnt.height >> 1 );
		}
		
		private function onAccueilComplete(e:Event):void 
		{
			acc = swfLoader.getLastItem() as Accueil;
			swfLoader.reset();
			swfLoader.removeEventListener( Event.COMPLETE, onAccueilComplete );
			
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			cnt.addChild( acc );
			onResize( null );
			
			step++;
		}
		
		private function onStepComplete(e:Event):void 
		{
			switch( step )
			{
				case 1: load( SWFs.PORTRAIT ); break;
				case 2: load( SWFs.TABLE ); break;
				case 3: backToAccueil(); break;
			}
		}
		
		private function onPortraitComplete(e:Event):void 
		{
			por = swfLoader.getLastItem() as Portrait;
			swfLoader.reset();
			swfLoader.removeEventListener( Event.COMPLETE, onPortraitComplete );
			
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			cnt.addChild( por );
			onResize( null );
			
			step++;
		}
		
		private function onTableComplete(e:Event):void 
		{
			tab = swfLoader.getLastItem() as MovieClip;
			swfLoader.reset();
			swfLoader.removeEventListener( Event.COMPLETE, onTableComplete );
			
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			cnt.addChild( tab );
			onResize( null );
			
			step++;
		}
		
		// PRIVATE
		
		private function backToAccueil():void
		{
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			cnt.addChild( acc );
			onResize( null );
			
			step = 1;
		}
		
		private function load( url:String ):void
		{
			switch ( url )
			{
				case SWFs.PORTRAIT:	swfLoader.addEventListener( Event.COMPLETE, onPortraitComplete ); break;
				case SWFs.TABLE: swfLoader.addEventListener( Event.COMPLETE, onTableComplete );
			}
			
			swfLoader.add( url, "temp" );
			swfLoader.load();
		}
		
		// PUBLIC
		
		public function getPortraitInfos():Object
		{
			return por.getPortraitInfos();
		}
		
	}
	
}