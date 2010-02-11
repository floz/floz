
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	import games.scenes.tiles.Tile;
	import games.scenes.types.RepresentationType;
	import games.scenes.World;
	
	public class Main extends Sprite 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _datas:Array = [ [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1 ],
									 [ 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0 ],
									 [ 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0 ],
									 [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0 ],
									 [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0 ],
									 [ 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0 ],
									 [ 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0 ] ];
		
		private var _world:World;
		
		[Embed(source="../docs/arbre.png" )]
		private var _arbre:Class;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_world = new World( 32, _datas, RepresentationType.ISOMETRIC );
			_world.x = ( stage.stageWidth - _world.width ) * .5;
			_world.y = ( stage.stageHeight - _world.height ) * .5;
			_world.showGrid = true;
			addChild( _world );
			
			addEventListener( MouseEvent.CLICK, clickHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function clickHandler(e:MouseEvent):void 
		{
			var p:Point3D = IsoMath.screenToIso( _world.mouseX, _world.mouseY );
			var tile:Tile = _world.getGridTile( p.x >> 5, p.y >> 5 );
			if ( !tile ) return;
			
			tile.color = 0xff0000;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}