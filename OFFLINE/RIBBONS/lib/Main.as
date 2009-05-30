
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import painting.brushes.DuplicateLines;
	import painting.brushes.IBrush;
	import painting.brushes.Line;
	import painting.brushes.MultiDuplicateLines;
	import painting.brushes.MultiLines;
	import painting.brushes.MultiRibbons;
	import painting.brushes.Ribbon;
	import painting.brushes.SharpLines;
	import painting.Canvas;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var canvas:Canvas;
		private var multiRibbons:MultiRibbons;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			canvas = new Canvas( stage.stageWidth, stage.stageHeight, false, 0x0A494C );
			addChild( canvas );
			
			//canvas.addBrush( new MultiLines( 8, 0, .02, Vector.<uint>( [ 0xFF3219, 0xB21300, 0xFF1B00, 0x00B257, 0x00FF7D, 0xFFAC4C, 0x7F4400, 0xFF8900 ] ) ) );
			var c:Vector.<Array> = new Vector.<Array>( 4, true );
			c[ 0 ] = [ 0xFF3219, 0xB21300, 0xFF1B00, 0x00B257, 0x00FF7D ];
			c[ 1 ] = [ 0xFFAC4C, 0x7F4400, 0xFF8900, 0x7F5626, 0xC46A00 ];
			c[ 2 ] = [ 0xFF53B9, 0x7F044D, 0xFF089B, 0x7F2A5D, 0xC40678 ];
			c[ 3 ] = [ 0xFFAC4C, 0x7F4400, 0xFF8900, 0x7F5626, 0xC46A00 ];
			
			var a:Vector.<Array> = new Vector.<Array>( 4, true );
			a[ 0 ] = [ .2, .2, .2, .2, .2 ];
			a[ 1 ] = [ .5, .5, .5, .5, .5 ];
			a[ 2 ] = [ .55, .55, .55, .55, .55 ];
			a[ 3 ] = [ .7, .7, .7, .7, .7 ];
			
			Ribbon.FRICTION = .9;
			Ribbon.RIBBON_SIZE = 45;
			Ribbon.SLOWDOWN = .05;
			
			multiRibbons = new MultiRibbons( 4, .01, .03, c, a );
			
			//canvas.addBrush( multiRibbons );
			//canvas.addBrush( new Ribbon( [ 0xFFBC0D, 0x889C1E, 0xFF6300, 0x74D5B0, 0x9C327D ], [ .8, .8, .8, .8, .8 ], true ) );
			canvas.addBrush( new SharpLines( 0xFFBC0D, 15, 20 ) );
			//var brushDL:DuplicateLines = new DuplicateLines( c[ 3 ], 8, 5, false, true );
			//brushDL.yAxe = true;
			//canvas.addBrush( brushDL );
			//var brush:MultiDuplicateLines = new MultiDuplicateLines( 5, 8, 5, false, true, .7, 0, .02 );
			//brush.xAxe = true;
			//brush.yAxe = true;
			//canvas.addBrush( brush );
			
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onDown(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
			canvas.startPainting();
		}
		
		private function onUp(e:MouseEvent):void 
		{
			canvas.stopPainting();
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch( e.charCode )
			{
				
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}