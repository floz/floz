package utils.fps 
{
	import fl.accessibility.AccImpl;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class FPS2 extends Sprite
	{
		private static const WIDTH:int = 200;
		private static const HEIGHT:int = 50;
		
		private var fpsText:TextField;
		private var bitmapData:BitmapData;
		private var bitmap:Bitmap;
		
		public function FPS2() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedToStage );
			removeEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			fpsText = new TextField();
			fpsText.width = 50;
			fpsText.height = 20;
			fpsText.defaultTextFormat = new TextFormat( "Verdana", 9, 0xFF0000 );
			fpsText.text = "FPS : ...";
			fpsText.selectable = false;
			addChild( fpsText );
			
			bitmapData = new BitmapData( WIDTH, HEIGHT, true, 0x000000 );
			bitmap = new Bitmap( bitmapData, PixelSnapping.AUTO, false );
			addChild( bitmap );
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(e:Event):void 
		{
			affiche();
		}
		
		// PRIVATE
		
		private function affiche():void
		{
			
		}
		
		// PUBLIC
	}
	
}