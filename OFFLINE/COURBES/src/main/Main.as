
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class Main extends MovieClip
	{
		private var _count:int;
		
		private var _posX:int;		
		private var _output:BitmapData;
		private var _shape:Shape;
		
		public function Main() 
		{
			_posX = stage.stageWidth * .5;
			
			_output = new BitmapData( stage.stageWidth, stage.stageHeight, false, 0x000000 );
			addChild( new Bitmap( _output ) );
			
			_shape = new Shape();
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// EVENTS
		
		private function onFrame(e:Event):void 
		{
			_count++;
			
			_shape.graphics.clear();
			_shape.graphics.beginFill( 0xff00ff );
			_shape.graphics.drawRect( _count, Math.sin( _count * .05 ) * 50, 1, 1 ); // SINUS
			_shape.graphics.endFill();
			
			_output.draw( _shape, new Matrix( 1, 0, 0, 1, 0, stage.stageHeight * .5 ) );
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}