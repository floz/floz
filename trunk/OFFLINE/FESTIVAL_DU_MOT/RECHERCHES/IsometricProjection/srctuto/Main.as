
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import fr.floz.isometric.Point3D;
	import fr.floz.isometric.UIso;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var p0:Point3D = new Point3D( 0, 0, 0 );
			var p1:Point3D = new Point3D( 46, 0, 0 );
			var p2:Point3D = new Point3D( 46, 0, 46 );
			var p3:Point3D = new Point3D( 0, 0, 46 );
			
			var sp0:Point = UIso.isoToScreen( p0 );
			var sp1:Point = UIso.isoToScreen( p1 );
			var sp2:Point = UIso.isoToScreen( p2 );
			var sp3:Point = UIso.isoToScreen( p3 );
			
			var tile:Sprite = new Sprite();
			tile.x = 200;
			tile.y = 200;
			addChild( tile );
			
			var g:Graphics = tile.graphics;
			g.lineStyle( 1 );
			g.moveTo( sp0.x, sp0.y );
			g.lineTo( sp1.x, sp1.y );
			g.lineTo( sp2.x, sp2.y );
			g.lineTo( sp3.x, sp3.y );
			g.lineTo( sp0.x, sp0.y );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}