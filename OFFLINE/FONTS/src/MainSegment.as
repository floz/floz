
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import fr.floz.geom.Segment;
	//import fr.floz.geom.Segment;
	
	public class MainSegment extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainSegment() 
		{
			var start:Point = new Point( stage.stageWidth * .5 - 10, stage.stageHeight * .5 );
			var anchor:Point = new Point( stage.stageWidth * .5 - 50, stage.stageHeight * .5 - 200 );
			var end:Point = new Point( stage.stageWidth * .5 + 300, stage.stageHeight * .5 );
			
			graphics.lineStyle( 1, 0x00ff00 );
			graphics.moveTo( start.x, start.y );
			graphics.curveTo( anchor.x, anchor.y, end.x, end.y );
			
			graphics.lineStyle( 1, 0xffcc00 );
			graphics.moveTo( start.x, start.y );
			graphics.lineTo( anchor.x, anchor.y );
			graphics.lineTo( end.x, end.y );
			
			var s:Segment = new Segment( start, end, anchor );
			
			var ratio:Number;
			var dx:Number = end.x - start.x;
			var dy:Number = end.y - start.y;
			var totalLength:Number = Math.sqrt( dx * dx + dy * dy );
			
			var adx:Number = anchor.x - start.x;
			var ady:Number = anchor.y - start.y;
			var anchorLength:Number = Math.sqrt( adx * adx + ady * ady );
			
			var ns:Segment = s.divide( anchorLength / totalLength );
			
			graphics.lineStyle( 1, 0xff0000 );
			graphics.moveTo( ns.start.x, ns.start.y );
			graphics.lineTo( ns.control.x, ns.control.y );
			graphics.lineTo( ns.end.x, ns.end.y );
			
			graphics.lineTo( ns.next.control.x, ns.next.control.y );
			graphics.lineTo( ns.next.end.x, ns.next.end.y );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}