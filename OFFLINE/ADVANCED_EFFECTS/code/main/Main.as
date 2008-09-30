package main 
{
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class Main extends MovieClip
	{
		private const POINT:Point = new Point( 0, 0 );
		private const CMF:ColorMatrixFilter = new ColorMatrixFilter( [ 1, 0, 0, 0, 0,
																	   0, 1, 0, 0, 0,
																	   0, 1, 0, 0, 0,
																	   0, 0, 0, 1, 0 ] );
		
		private var bmpd:BitmapData;
		private var fish:MovieClip;
		
		public function Main() 
		{
			bmpd = new BitmapData( stage.stageWidth, stage.stageHeight, false, 0x000000 );
			var bmp:Bitmap = new Bitmap( bmpd );
			addChild( bmp );
			
			fish = new Fish();
			addChild( fish );
			
			mover();
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// EVENTS
		
		private function onFrame(e:Event):void 
		{
			bmpd.draw( this );
			bmpd.applyFilter( bmpd, bmpd.rect, POINT, new BlurFilter( 15, 15, 5 ) );
			bmpd.applyFilter( bmpd, bmpd.rect, POINT, CMF );
			//bmpd.applyFilter( bmpd, bmpd.rect, POINT, new ConvolutionFilter( 3, 3, [ 1, 1, 1, 1, 1, 1, 1, 1, 1 ], 9, 0, false, false, 0xFF0000, 1 ) );
			bmpd.scroll( 0, -8 );
		}
		
		// PRIVATE
		
		private function mover():void
		{
			Tweener.addTween( fish, { 
				x: Math.random() * stage.stageWidth, 
				y: Math.random() * stage.stageHeight, 
				rotation: Math.random() * 360, 
				time: 1, 
				transition: "easeInOutQuad", 
				onComplete: mover 
				} );
		}
		
		// PUBLIC
		
	}
	
}