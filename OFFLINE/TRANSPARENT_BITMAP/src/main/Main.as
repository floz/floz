
/**
 * Written by :
 * @author ...
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import fr.minuit4.utils.UBit;
	//import havas.tools.FPS;
	import fr.minuit4.tools.FPS;
	
	public class Main extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			var b:Bitmap = new Bitmap( UBit.setGradientTransparent( new Feru( 0, 0 ), Math.PI ) );
			addChild( b );
			
			addChild( new FPS() );
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onFrame(e:Event):void 
		{
			//for ( var i:int; i < 100; i++ )
			//{
				var b:Bitmap = new Bitmap( new Feru( 0, 0 ) );
				b.x =
				b.y = 200;
				addChild( b );
			//}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}