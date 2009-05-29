
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
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			canvas = new Canvas( stage.stageWidth, stage.stageHeight, false, 0x0A494C );
			addChild( canvas );
			
			//canvas.addBrush( new MultiLines( 8, 0, .02 ) );
			var c:Vector.<Array> = new Vector.<Array>( 4, true );
			c[ 0 ] = [ 0xFF3219, 0xB21300, 0xFF1B00, 0x00B257, 0x00FF7D ];
			c[ 1 ] = [ 0xFFAC4C, 0x7F4400, 0xFF8900, 0x7F5626, 0xC46A00 ];
			c[ 2 ] = [ 0xFF53B9, 0x7F044D, 0xFF089B, 0x7F2A5D, 0xC40678 ];
			c[ 3 ] = [ 0xFFAC4C, 0x7F4400, 0xFF8900, 0x7F5626, 0xC46A00 ];
			
			var a:Vector.<Array> = new Vector.<Array>( 4, true );
			a[ 0 ] = [ .3, .1, .3, .8, .3 ];
			a[ 1 ] = [ .2, .4, .2, .2, .7 ];
			a[ 2 ] = [ .4, .1, .6, .1, .4 ];
			a[ 3 ] = [ .1, .2, .1, .7, .3 ];
			
			Ribbon.FRICTION = .8;
			Ribbon.RIBBON_SIZE = .45;
			Ribbon.SLOWDOWN = .05;
			
			canvas.addBrush( new MultiRibbons( 4, 0, .01, c, a ) );
			//canvas.addBrush( new Ribbon( Vector.<uint>( [ 0xFFBC0D, 0x889C1E, 0xFF6300, 0x74D5B0, 0x9C327D ] ), true ) );
			//canvas.addBrush( new SharpLines( 0x000000, 15, 20 ) );
			canvas.addBrush( new DuplicateLines( 0x000000, 10, 20, false, true ) );
			//var brush:MultiDuplicateLines = new MultiDuplicateLines( 5, 8, 5, false, true, .7, 0, .02 );
			//brush.xAxe = true;
			//brush.yAxe = true;
			//canvas.addBrush( brush );
			
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
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
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}