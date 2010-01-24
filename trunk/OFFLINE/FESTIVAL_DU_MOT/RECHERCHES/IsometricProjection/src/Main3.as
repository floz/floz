
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	
	public class Main3 extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main3() 
		{
			var s1:Shape = new Shape();
			s1.x = 50;
			s1.y = 100;
			addChild( s1 );
			
			var p1:Point3D = new Point3D( 0, 0, 0 );
			var p2:Point3D = new Point3D( 50, 0, 0 );
			var p3:Point3D = new Point3D( 50, 50, 0 );
			var p4:Point3D = new Point3D( 0, 50, 0 );
			
			var g:Graphics = s1.graphics;
			g.lineStyle( 1, 0xff0000 );
			g.moveTo( p1.x, p1.y );
			g.lineTo( p2.x, p2.y );
			g.lineTo( p3.x, p3.y );
			g.lineTo( p4.x, p4.y );
			g.lineTo( p1.x, p1.y );
			g.endFill();
			
			var s2:Shape = new Shape();
			s2.x = 150;
			s2.y = 100;
			addChild( s2 );
			
			p1 = IsoMath.isoToScreen( p1 );
			p2 = IsoMath.isoToScreen( p2 );
			p3 = IsoMath.isoToScreen( p3 );
			p4 = IsoMath.isoToScreen( p4 );
			
			trace( "P1 : " );
			trace( p1.x );
			trace( p1.y );
			trace( p1.z );
			
			trace( "P2 : " );
			trace( p2.x );
			trace( p2.y );
			trace( p2.z );
			
			trace( "P3 : " );
			trace( p3.x );
			trace( p3.y );
			trace( p3.z );
			
			trace( "P4 : " );
			trace( p4.x );
			trace( p4.y );
			trace( p4.z );
			
			g = s2.graphics;
			g.lineStyle( 1, 0x00ff00 );
			g.moveTo( p1.x, p1.y );
			g.lineTo( p2.x, p2.y );
			g.lineTo( p3.x, p3.y );
			g.lineTo( p4.x, p4.y );
			g.lineTo( p1.x, p1.y );
			g.endFill();
			
			var s3:Shape = new Shape();
			s3.x = 200;
			s3.y = 100;
			addChild( s3 );
			
			p1 = IsoMath.screenToIso( p1 );
			p2 = IsoMath.screenToIso( p2 );
			p3 = IsoMath.screenToIso( p3 );
			p4 = IsoMath.screenToIso( p4 );
			
			g = s3.graphics;
			g.lineStyle( 1, 0x0000ff );
			g.moveTo( p1.x, p1.y );
			g.lineTo( p2.x, p2.y );
			g.lineTo( p3.x, p3.y );
			g.lineTo( p4.x, p4.y );
			g.lineTo( p1.x, p1.y );
			g.endFill();
			
			trace( "------" );
			trace( "P1 : " );
			trace( p1.x );
			trace( p1.y );
			trace( p1.z );
			
			trace( "P2 : " );
			trace( p2.x );
			trace( p2.y );
			trace( p2.z );
			
			trace( "P3 : " );
			trace( p3.x );
			trace( p3.y );
			trace( p3.z );
			
			trace( "P4 : " );
			trace( p4.x );
			trace( p4.y );
			trace( p4.z );
			
			trace( "-----" );
			
			trace( s1.width );
			trace( s2.width );
			trace( s3.width );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}