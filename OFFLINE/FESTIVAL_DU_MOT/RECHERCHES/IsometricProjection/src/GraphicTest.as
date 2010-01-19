
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
	import fr.floz.isometric.DrawIsoTile;
	import fr.floz.isometric.GraphicTile;
	import fr.floz.isometric.IsoWorld;
	import fr.floz.isometric.Point3D;
	import fr.floz.isometric.UIso;
	
	public class GraphicTest extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private const TILE_SIZE:int = 40;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		[Embed (source = "../docs/tile1.png")]
		private var _tile1:Class;
		
		[Embed (source = "../docs/tile2.png")]
		private var _tile2:Class;
		
		private var _world:IsoWorld;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GraphicTest() 
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
					var tile:GraphicTile = new GraphicTile( TILE_SIZE, _tile1, TILE_SIZE, TILE_SIZE * .5 );
					//var tile:DrawIsoTile = new DrawIsoTile( TILE_SIZE, 0xff00ff );
					tile.setPosition( new Point3D( i * TILE_SIZE, 0, j * TILE_SIZE ) );
					_world.addChildToFloor( tile );
					trace( tile.width );
				}
			}
			
			stage.addEventListener( MouseEvent.CLICK, clickHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function clickHandler(e:MouseEvent):void 
		{
			var box:GraphicTile = new GraphicTile( TILE_SIZE, _tile2, TILE_SIZE, TILE_SIZE + TILE_SIZE * .5 * .5 );
			
			var p:Point3D = UIso.screenToIso( new Point( _world.mouseX, _world.mouseY ) );
			p.x = Math.round( p.x / TILE_SIZE ) * TILE_SIZE;
			p.y = Math.round( p.y / TILE_SIZE ) * TILE_SIZE;
			p.z = Math.round( p.z / TILE_SIZE ) * TILE_SIZE;
			box.setPosition( p );
			_world.addChildToWorld( box );
			
			_world.sort();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}