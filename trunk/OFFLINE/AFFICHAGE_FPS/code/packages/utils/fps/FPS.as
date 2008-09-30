package utils.fps 
{
	import fl.transitions.PixelDissolve;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class FPS extends Sprite
	{
		private static const WIDTH:int = 200;
		private static const HEIGHT:int = 50;
		
		private var fpsMax:int;		
		private var bitmapData:BitmapData;
		private var bitmap:Bitmap;
		private var transparence:Boolean;
		private var fpsShape:Shape;
		private var p0:Pixel;
		private var memoryShape:Shape;
		private var p1:Pixel;
		private var fpsText:TextField;
		private var memoryText:TextField;
		private var ms:int;
		private var fps:int;
		
		private var time:Number;
		private var secondTime:Number;
		private var prevSecondTime:Number = getTimer();
		private var frames:String = "...";
		private var memory:Number = 0;
		
		public function FPS() 
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
			
			fpsMax = stage.frameRate;
			
			bitmapData = new BitmapData( WIDTH, HEIGHT, transparence, 0x000000 );
			bitmap = new Bitmap( bitmapData, PixelSnapping.AUTO, false );
			addChild( bitmap );
			
			fpsShape = new Shape();
			p0 = new Pixel();
			memoryShape = new Shape();
			p1 = new Pixel( 0, this.height );
			
			fpsText = new TextField();
			fpsText.width = 200;
			fpsText.height = 20;
			fpsText.defaultTextFormat = new TextFormat( "Verdana", 9, 0xFF0000 );
			fpsText.text = "FPS : " + frames;
			addChild( fpsText );
			
			memoryText = new TextField();
			memoryText.x = 125;
			memoryText.width = 200;
			memoryText.height = 20;
			memoryText.defaultTextFormat = new TextFormat( "Verdana", 9, 0x33FF00 );
			memoryText.text = "MEM : ...";
			addChild( memoryText );
			
			ms = getTimer();
			fps = 0;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(e:Event):void 
		{
			time = getTimer();
			
			fpsShape.graphics.clear();
			fpsShape.graphics.lineStyle( 0, 0xFF0000, 1 );
			fpsShape.graphics.moveTo( p0.sx, p0.sy );
			
			memoryShape.graphics.clear();
			memoryShape.graphics.lineStyle( 0, 0x33FF00, 1 );
			memoryShape.graphics.moveTo( p1.sx, p1.sy );
			
			secondTime = time - prevSecondTime;
			
			if ( secondTime >= 1000 )
			{
				frames = fps.toString();
				memory = ( System.totalMemory / 1024 / 1024 );
				
				p0.vy = ( this.height - 20 ) - ( fps * ( ( this.height - 20 ) / fpsMax ) ) - 1; // a checker pour que ce soit plus propre	
				p1.vy = ( this.height - 20 ) - ( memory * ( this.height - 20 ) / 100 ) - 1;
				
				fps = 0;
				prevSecondTime = time;
				
				p0.vx += 1;
				p0.sx = p0.vx;
				p0.sy = p0.vy;	
				
				p1.vx += 1;
				p1.sx = p1.vx;
				p1.sy = p1.vy;
				
				//bitmapData.scroll( 1, 0 );
			} 
			else
			{
				fps++;
			}
			
			fpsShape.graphics.lineTo( p0.vx, p0.vy );
			bitmapData.draw( fpsShape, new Matrix( 1, 0, 0, 1, 0, 20 ) );
			fpsText.text = "FPS : " + frames;
			
			memoryShape.graphics.lineTo( p1.vx, p1.vy );			
			bitmapData.draw( memoryShape, new Matrix( 1, 0, 0, 1, 0, 20 ) );			
			memoryText.text = memory == 0 ? "MEM : ..." : "MEM : " +  memory.toString().substr(0, 4);
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}