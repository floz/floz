
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const TILE_SIZE:Number = 32;
		
		private var _normalMap:Sprite;
		private var _isoMap:Sprite;
		
		private var _map:/*Array*/Array = [ [ 0, 0, 0, 1, 0 ],
											[ 0, 1, 0, 0, 1 ],
											[ 0, 1, 1, 0, 1 ],
											[ 0, 1, 0, 0, 0 ],
											[ 1, 0, 0, 0, 0 ] ];
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_normalMap = new Sprite();
			addChild( _normalMap );
			
			_isoMap = new Sprite();
			addChild( _isoMap );
			
			render();
			place();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function render():void
		{
			drawNormalMap();
			drawIsoMap();
		}
		
		private function drawNormalMap():void
		{
			var tile:Shape;
			var g:Graphics;
			
			var px:Number = 0;
			var py:Number = 0;
			
			var j:int, m:int;
			var n:int = _map.length;
			for ( var i:int; i < n; ++i ) // y
			{
				px = 0;
				m = _map[ i ].length;
				for ( j = 0; j < m; ++j ) // x
				{
					tile = new Shape();
					_normalMap.addChild( tile );
					
					g = tile.graphics;
					g.lineStyle( 1, 0x000000, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER ); // A commenter pour avoir la width / 32 ronde
					g.beginFill( _map[ i ][ j ] ? 0x444444 : 0xeeeeee );
					g.drawRect( 0, 0, TILE_SIZE, TILE_SIZE );
					g.endFill();
					
					tile.x = px;
					tile.y = py;
					px += TILE_SIZE;
				}
				py += TILE_SIZE;
			}
		}
		
		private function drawIsoMap():void
		{
			var tile:Shape;
			var g:Graphics;
			
			var px:Number = 0;
			var py:Number = 0;
			var pos:Point3D = new Point3D();
			
			var j:int, m:int;
			var n:int = _map.length;
			for ( var i:int; i < n; ++i ) // y
			{
				pos.x = 0;
				m = _map[ i ].length;
				for ( j = 0; j < m; ++j ) // x
				{
					tile = new Shape();
					_isoMap.addChild( tile );
					
					g = tile.graphics;
					g.lineStyle( 1, 0x000000, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER ); // A commenter pour avoir la width / 32 ronde
					g.beginFill( _map[ i ][ j ] ? 0x444444 : 0xeeeeee );
					g.moveTo( 0, 0 );
					g.lineTo( IsoMath.isoToScreen( new Point3D( TILE_SIZE, 0 ) ).x, IsoMath.isoToScreen( new Point3D( TILE_SIZE, 0 ) ).y );
					g.lineTo( IsoMath.isoToScreen( new Point3D( TILE_SIZE, TILE_SIZE ) ).x, IsoMath.isoToScreen( new Point3D( TILE_SIZE, TILE_SIZE ) ).y );
					g.lineTo( IsoMath.isoToScreen( new Point3D( 0, TILE_SIZE ) ).x, IsoMath.isoToScreen( new Point3D( 0, TILE_SIZE ) ).y );
					g.lineTo( 0, 0 );
					g.endFill();
					
					tile.x = IsoMath.isoToScreen( pos ).x;
					tile.y = IsoMath.isoToScreen( pos ).y;
					pos.x += TILE_SIZE;
				}
				pos.y += TILE_SIZE;
			}
		}
		
		private function place():void
		{
			_normalMap.x = _normalMap.width * .5;
			_normalMap.y = ( stage.stageHeight - _normalMap.height ) * .5;
			
			_isoMap.x = stage.stageWidth - _isoMap.width * .5 - _isoMap.width * .25;
			_isoMap.y = ( stage.stageHeight - _isoMap.height ) * .5;
			
			trace( _normalMap.width );
			trace( _isoMap.width );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}