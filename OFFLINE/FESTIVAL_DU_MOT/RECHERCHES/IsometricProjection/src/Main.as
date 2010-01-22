
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			var p1:Pt = new Pt( 0, 0 );
			var p2:Pt = new Pt( 100, 0 );
			var p3:Pt = new Pt( 100, 100 );
			var p4:Pt = new Pt( 0, 100 );
			
			p1 = IsoMath.isoToScreen( p1 );
			p2 = IsoMath.isoToScreen( p2 );
			p3 = IsoMath.isoToScreen( p3 );
			p4 = IsoMath.isoToScreen( p4 );
			
			var s:Sprite = new Sprite();
			s.x = 300;
			s.y = 200;
			addChild( s );
			
			var g:Graphics = s.graphics;
			g.lineStyle( 1, 0x000000 );
			g.moveTo( p1.x, p1.y );
			g.lineTo( p2.x, p2.y );
			g.lineTo( p3.x, p3.y );
			g.lineTo( p4.x, p4.y );
			g.lineTo( p1.x, p1.y );
			g.endFill();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}