
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.utils.debug.FPS;
	import painting.brushes.BrushManager;
	import painting.brushes.lines.Line;
	import painting.brushes.ribbons.Ribbon;
	import painting.Canvas;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var canvas:Canvas;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			canvas = new Canvas( stage.stageWidth, stage.stageHeight, false, 0x405560 );
			addChild( canvas );
			
			var multiRibbon:BrushManager = new BrushManager();
			multiRibbon.addBrush( new Ribbon( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7 ] ) ) );
			multiRibbon.addBrush( new Ribbon( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7 ] ), .02 ) );
			multiRibbon.addBrush( new Ribbon( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7 ] ), -.02 ) );
			multiRibbon.addBrush( new Ribbon( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7 ] ), 0, .02 ) );
			multiRibbon.addBrush( new Ribbon( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7 ] ), 0, -.02 ) );
			multiRibbon.addBrush( new Line( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7 ] ) ) );
			multiRibbon.addBrush( new Line( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7 ] ), .02 ) );
			multiRibbon.addBrush( new Line( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7 ] ), -.02 ) );
			multiRibbon.addBrush( new Line( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7 ] ), 0, .02 ) );
			multiRibbon.addBrush( new Line( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7 ] ), 0, -.02 ) );
			canvas.addBrush( multiRibbon );
			
			addChild( new FPS() );
			
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
			stage.removeEventListener( MouseEvent.MOUSE_UP, onUp );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}