
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
	import fr.floz.isometric.IsoWorld;
	import fr.floz.isometric.Point3D;
	import fr.floz.isometric.UIso;
	
	public class DepthTest extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private const TILE_SIZE:int = 40;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _world:IsoWorld;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DepthTest() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_world = new IsoWorld();
			_world.x = stage.stageWidth * .5;
			_world.y = 100;
			addChild( _world );
			
			var j:int;
			var n:int = stage.stageWidth * .5 / TILE_SIZE;
			for ( var i:int; i < n; ++i )
			{
				for ( j = 0; j < n; ++j )
				{
					var tile:DrawIsoTile = new DrawIsoTile( TILE_SIZE, 0xcccccc );
					tile.setPosition( new Point3D( i * TILE_SIZE, 0, j * TILE_SIZE ) );
					_world.addChildToFloor( tile );
				}
			}
			
			_world.addEventListener( MouseEvent.CLICK, clicHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function clicHandler(e:MouseEvent):void 
		{
			var b:DrawIsoBox = new DrawIsoBox( TILE_SIZE, Math.random() * 0xffffff, 20 );
			
			var p:Point3D = UIso.screenToIso( new Point( _world.mouseX, _world.mouseY ) );
			p.x = Math.round( p.x / TILE_SIZE ) * TILE_SIZE;
			p.y = Math.round( p.y / TILE_SIZE ) * TILE_SIZE;
			p.z = Math.round( p.z / TILE_SIZE ) * TILE_SIZE;
			
			b.setPosition( p );
			_world.addChildToWorld( b );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}