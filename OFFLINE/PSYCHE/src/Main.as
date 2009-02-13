package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	[SWF( backgroundColor='0x000000', frameRate='30', width='800', height='600')]
	public class Main extends Sprite 
	{
		private var bmpd:BitmapData;		
		private var particules:Array;
		
		private var shape:Shape;
		
		private var vx:Number = 0;
		private var vy:Number = 0;

		
		
		public function Main():void 
		{		
			bmpd = new BitmapData( stage.stageWidth, stage.stageHeight, true, 0x00 );
			var b:Bitmap = new Bitmap( bmpd );
			addChild( b );
			
			particules = [];
			
			var p:Particule;
			for ( var i:int; i < 2; i++ )
			{
				p = new Particule( stage.mouseX, stage.mouseY - i * 50 );
				p.vx = stage.mouseX;
				p.vy = stage.mouseY - i * 50;
				particules.push( p );
			}
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// EVENTS
		
		private function onFrame(e:Event):void 
		{
			render();
		}
		
		// PRIVATE
		
		private function render():void
		{
			shape = new Shape();
			
			shape.graphics.clear();
			shape.graphics.lineStyle( 0, 0xffffff, 1 );
			
			var p:Particule;
			for each( p in particules )
			{
				shape.graphics.moveTo( p.px, p.py );
				
				p.vx -= ( ( p.px - stage.mouseX ) * .2 ) * .98;
				p.vy -= ( ( p.py - stage.mouseY ) * .2 ) * .98;
				
				p.px += p.vx / 100;
				p.py += p.vy / 100;
				
				shape.graphics.lineTo( p.px, p.py );
			}
			
			//shape.graphics.moveTo( vx, vy );
			
			//shape.graphics.lineTo( vx, vy );
			
			bmpd.draw( shape );
		}
		
		// PUBLIC
		
	}
	
}