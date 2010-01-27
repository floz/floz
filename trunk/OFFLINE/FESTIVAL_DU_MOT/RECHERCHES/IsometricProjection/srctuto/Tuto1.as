
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package 
{
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	import flash.display.Sprite;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	
	public class Tuto1 extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Tuto1() 
		{
			var box:IsoBox = new IsoBox();
			box.setSize( 25, 25, 0 );
			box.moveTo( 200, 200, 50 );
			
			var scene:IsoScene = new IsoScene();
			scene.hostContainer = this;
			scene.addChild( box );
			
			
			var g:IsoGrid = new IsoGrid();
			g.cellSize = 25;
			g.setGridSize( stage.stageWidth / 50, stage.stageHeight / 25, 0 );
			g.x = IsoMath.screenToIso( new Point3D( stage.stageWidth * .5, 0, 0 ) ).x;
			g.y = IsoMath.screenToIso( new Point3D( stage.stageWidth * .5, 0, 0 ) ).y;
			//g.y = -stage.stageHeight * .5;
			scene.addChild( g );
			scene.render();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}