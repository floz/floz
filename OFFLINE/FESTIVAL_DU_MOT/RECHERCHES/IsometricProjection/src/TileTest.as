
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import fr.floz.isometric.DrawIsoBox;
	import fr.floz.isometric.DrawIsoTile;
	import fr.floz.isometric.Point3D;
	import fr.floz.isometric.UIso;
	import net.badimon.five3D.utils.DrawingUtils;
	
	public class TileTest extends Sprite
	{
		private var world:Sprite;
		
		// - CONSTS ----------------------------------------------------------------------
		
		private const TILE_SIZE:int = 40;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TileTest() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			world = new Sprite();
			world.x = stage.stageWidth * .5;
			addChild( world );
			
			var tile:DrawIsoTile;
			var j:int;
			var n:int = stage.stageWidth * .5 / TILE_SIZE;
			for ( var i:int; i < n; ++i )
			{
				for ( j = 0; j < n; ++j )
				{
					tile = new DrawIsoTile( TILE_SIZE, 0xcccccc );
					tile.setPosition( new Point3D( i * TILE_SIZE, 0, j * TILE_SIZE ) );
					world.addChild( tile );
				}
			}
			
			world.y = ( stage.stageHeight - world.height ) * .5;
			
			world.addEventListener( MouseEvent.CLICK, clickWorldHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function clickWorldHandler(e:MouseEvent):void 
		{
			var b:DrawIsoBox = new DrawIsoBox( TILE_SIZE, Math.random() * 0xffffff, 20 );
			
			var p:Point3D = UIso.screenToIso( new Point( world.mouseX, world.mouseY ) );
			p.x = Math.round( p.x / TILE_SIZE ) * TILE_SIZE;
			p.y = Math.round( p.y / TILE_SIZE ) * TILE_SIZE;
			p.z = Math.round( p.z / TILE_SIZE ) * TILE_SIZE;
			
			b.setPosition( p );
			world.addChild( b );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}