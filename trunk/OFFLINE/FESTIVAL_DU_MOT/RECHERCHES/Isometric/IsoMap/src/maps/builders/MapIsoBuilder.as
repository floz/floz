
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.builders 
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	import maps.IMap;
	import maps.Tile;
	
	public class MapIsoBuilder extends MapBuilder
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MapIsoBuilder() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function build( map:IMap ):void 
		{
			super.build( map );
			
			var tile:Tile;
			var g:Graphics;
			var mapDatas:/*Array*/Array = map.mapDatas;
			var a:Array;
			
			var px:Number = 0;
			var py:Number = 0;
			var p:Point3D;
			var pos:Point3D = new Point3D();
			
			var n:int = mapDatas.length;
			trace( "n : " + n );
			var j:int, m:int;
			for ( var i:int; i < n; ++i )
			{
				a = [];
				
				pos.x = 0;
				m = mapDatas[ i ].length;
				for ( j = 0; j < m; ++j )
				{
					tile = new Tile();
					map.addChild( tile );
					a.push( tile );
					
					g = tile.graphics;
					g.lineStyle( 1, 0x000000, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER );
					g.beginFill( mapDatas[ i ][ j ] ? 0x444444 : 0xeeeeee );
					g.moveTo( 0, 0 );
					p = IsoMath.isoToScreen( new Point3D( map.tileSize, 0 ) );
					g.lineTo( p.x, p.y );
					p = IsoMath.isoToScreen( new Point3D( map.tileSize, map.tileSize ) );
					g.lineTo( p.x, p.y );
					p = IsoMath.isoToScreen( new Point3D( 0, map.tileSize ) );
					g.lineTo( p.x, p.y );
					g.lineTo( 0, 0 );
					
					p = IsoMath.isoToScreen( pos );
					tile.x = p.x;
					tile.y = p.y;
					pos.x += map.tileSize;
				}
				pos.y += map.tileSize;
				
				_tiles.push( a );
			}
			trace( _tiles.length );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}