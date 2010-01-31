
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
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Main2 extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main2() 
		{
			var p1:Pt = new Pt( 0, 0 );
			var p2:Pt = new Pt( 100, 0 );
			var p3:Pt = new Pt( 100, 100 );
			var p4:Pt = new Pt( 0, 100 );
			
			var s2:Shape = new Shape();
			s2.x = 50;
			s2.y = 200;
			addChild( s2 );
			
			var g:Graphics = s2.graphics;
			g.lineStyle( 1, 0xff0000 );
			g.moveTo( p1.x, p1.y );
			g.lineTo( p2.x, p2.y );
			g.lineTo( p3.x, p3.y );
			g.lineTo( p4.x, p4.y );
			g.lineTo( p1.x, p1.y );
			g.endFill();
			
			p1 = IsoMath.isoToScreen( p1 );
			p2 = IsoMath.isoToScreen( p2 );
			p3 = IsoMath.isoToScreen( p3 );
			p4 = IsoMath.isoToScreen( p4 );
			
			var s:Sprite = new Sprite();
			s.x = 325;
			s.y = 200;
			addChild( s );
			
			g = s.graphics;
			g.lineStyle( 1, 0x00ff00 );
			g.moveTo( p1.x, p1.y );
			g.lineTo( p2.x, p2.y );
			g.lineTo( p3.x, p3.y );
			g.lineTo( p4.x, p4.y );
			g.lineTo( p1.x, p1.y );
			g.endFill();
			
			var sh:Shape = new Shape();
			sh.x = 500;
			sh.y = 200;
			addChild( sh );
			
			p1 = IsoMath.screenToIso( p1 );
			p2 = IsoMath.screenToIso( p2 );
			p3 = IsoMath.screenToIso( p3 );
			p4 = IsoMath.screenToIso( p4 );
			
			g = sh.graphics;
			g.lineStyle( 1, 0x0000ff );
			g.moveTo( p1.x, p1.y );
			g.lineTo( p2.x, p2.y );
			g.lineTo( p3.x, p3.y );
			g.lineTo( p4.x, p4.y );
			g.lineTo( p1.x, p1.y );
			g.endFill();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function screenToIso( p:Point ):Point
		{
			//var y:Number = (p.x + p.y) * .5//* 0.4472135954999579;
			//var x:Number = (p.x - p.y) //* 0.8944271909999159;
			
			//var x:Number = p.y + p.x * .5;
			//var y:Number = p.y - p.x * .5;
			var sx:Number = p.x - p.y;
			var sy:Number = ( p.x + p.y ) * .5;
			
			return new Point( sx, sy );
			
			//return new Point( x, y );
		}
		
		private function isoToScreen( p:Point ):Point
		{
			//var z:Number = spacePt.z;
			//var y:Number = (spacePt.x + spacePt.y) / ratio - spacePt.z;
			//var x:Number = spacePt.x - spacePt.y;
			
			//var x:Number = p.y + p.x * .5;
			//var y:Number = 0;
			//var z:Number = p.y - p.x * .5;
			
			// OK
			//var sx:Number = p.y + p.x * .5;
			//var sy:Number = p.y - p.x * .5;
			
			var sx:Number = ( p.y + p.x ) * .5;
			var sy:Number = p.x - p.y;// * .5;
			
			return new Point( sx, sy );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}