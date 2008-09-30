package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	public class Etoiles extends Sprite
	{
		private var bitmap:Bitmap;
		private var sx:Number;
		private var sy:Number;
		
		public function Etoiles() 
		{
			bitmap = new Bitmap( new BitmapData( 550, 400, false, 0x000000 ), PixelSnapping.AUTO, false );
			addChild( bitmap );
			
			sx = 0;
			sy = 0;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(e:Event):void 
		{
			var bitmapData:BitmapData = bitmap.bitmapData;
			
			bitmapData.colorTransform( bitmapData.rect, new ColorTransform( -1, 1, 1, 1, 0, 0, 0, -1 ) );
			
			sx = Math.random() * 550 - 550 / 2;
			sy = Math.random() * 400 - 400 / 2;
			
			var shape:Shape = new Shape();
			shape.graphics.clear();
			shape.graphics.lineStyle( 0, 0xffffff, 1 );
			shape.graphics.moveTo( sx, sy );
			
			shape.graphics.lineTo( sx+1, sy+1 );
			
			bitmapData.draw( shape, new Matrix( 1, 0, 0, 1 , 550 >> 1, 400 >> 1 ) );
		}
		
	}
	
}