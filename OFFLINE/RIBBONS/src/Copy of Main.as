
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import fr.minuit4.utils.debug.FPS;
	//import painting.brushes.lines.types.Multiline;
	//import painting.brushes.lines.types.SimpleLine;
	import painting.brushes.ribbons.type.MultiRibbon;
	import painting.brushes.ribbons.type.SimpleRibbon;
	import painting.Canvas;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var canvas:Canvas;
		//private var simpleLine:SimpleLine;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			canvas = new Canvas( stage.stageWidth, stage.stageHeight );
			addChild( canvas );
			
			//simpleLine = new SimpleLine( Vector.<uint>( [ 0x000000 ] ), Vector.<Number>( [ 1 ] ) );
			//var multiline:Multiline = new Multiline();
			//multiline.addLine( simpleLine );
			//multiline.addLine( new SimpleLine( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ 1 ] ), .02 ) );
			//multiline.addLine( new SimpleLine( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ 1 ] ), .0, .02 ) );
			//multiline.addLine( new SimpleLine( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ 1 ] ), .0, -.02 ) );
			//canvas.addBrush( musltiline );
			
			var multiRibbon:MultiRibbon = new MultiRibbon();
			multiRibbon.addRibbon( new SimpleRibbon( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7, .5 ] ) ) );
			multiRibbon.addRibbon( new SimpleRibbon( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7, .5 ] ), .02 ) );
			multiRibbon.addRibbon( new SimpleRibbon( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7, .5 ] ), -.02 ) );
			multiRibbon.addRibbon( new SimpleRibbon( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7, .5 ] ), 0, .02 ) );
			multiRibbon.addRibbon( new SimpleRibbon( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff ] ), Vector.<Number>( [ .7, .5 ] ), 0, -.02 ) );
			//multiRibbon.addRibbon( new SimpleRibbon( Vector.<uint>( [ 0xff0000 ] ), Vector.<Number>( [ .7 ] ), 0, .02 ) );
			//multiRibbon.addRibbon( new SimpleRibbon( Vector.<uint>( [ 0x0000ff ] ), Vector.<Number>( [ .7 ] ), 0, -.02 ) );
			canvas.addBrush( multiRibbon );
			addChild( multiRibbon );
			
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
			//simpleLine.setColors( Vector.<uint>( [ Math.random() * 0xffffff, Math.random() * 0xffffff, Math.random() * 0xffffff ] ) );
			//simpleLine.setAlphas( Vector.<Number>( [ 1, .5 ] ) );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onUp );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}