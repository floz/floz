package main
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class Main extends Sprite 
	{
		private const ORIGIN:Point = new Point();
		
		private var _buffer:BitmapData;
		private var _output:BitmapData;
		private var _fireColors:Array;
		private var _explosions:Array;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_buffer = new BitmapData( stage.stageWidth, stage.stageHeight, false, 0 );
			_output = new BitmapData( stage.stageWidth, stage.stageHeight, false, 0 );
			
			_fireColors = Gradient.getArray
			(
				[ 0, 0, 0x333333, 0xff0000, 0xffff00, 0xffffff ],
				[ 0, 0, 1, 1, 1, 1 ],
				[ 0, 0x22, 0x44, 0x55, 0x88, 0xff ]
			);
			
			addChild( new Bitmap( _output ) );
			
			_explosions = [];
			
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			stage.addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onDown(e:MouseEvent):void 
		{
			var explosion:Explosion = new Explosion( mouseX, mouseY );
			
			_explosions.push( explosion );
		}
		
		private function onFrame(e:Event):void 
		{
			var explosion:Explosion;
			var i:int = _explosions.length;
			
			while ( --i > -1 )
			{
				trace ( i );
				explosion = _explosions[ i ];
				//explosion.render( buffer );
			}
			
			//_buffer.applyFilter( _buffer, _buffer.rect, ORIGIN, blur );
			_output.copyPixels( _buffer, _buffer.rect, ORIGIN );
			_output.paletteMap( _output, _output.rect, ORIGIN, [], [], _fireColors, [] );
			
			
		}
		
	}
	
}