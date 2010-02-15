
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.scenes.tiles.primitives 
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	import games.scenes.tiles.Tile;
	
	public class TileIso extends Tile
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const _position:Point3D = new Point3D();
		
		private var _p1:Point3D;
		private var _p2:Point3D;
		private var _p3:Point3D;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TileIso( size:int ) 
		{
			super( size );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function updateDatas():void 
		{
			_p1 = IsoMath.isoToScreen( _size, 0 );
			_p2 = IsoMath.isoToScreen( _size, _size );
			_p3 = IsoMath.isoToScreen( 0, _size );
			
			_datas[ 0 ] = 0;
			_datas[ 1 ] = 0;
			
			_datas[ 2 ] = _p1.x;
			_datas[ 3 ] = _p1.y;
			
			_datas[ 4 ] = _p2.x;
			_datas[ 5 ] = _p2.y;
			
			_datas[ 6 ] = _p3.x;
			_datas[ 7 ] = _p3.y;
			
			_datas[ 8 ] = 0;
			_datas[ 9 ] = 0;
		}
		
		override protected function build():void 
		{
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle( 1, 0x000000, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER );
			g.beginFill( _color, .2 );
			g.drawPath( _COMMANDS, _datas );
			g.endFill();
		}
		
		private function updatePosition():void
		{
			var p:Point3D = IsoMath.isoToScreen( _position.x, _position.y, _position.z );
			super.x = p.x;
			super.y = p.y;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		override public function get x():Number { return super.x; }
		
		override public function set x(value:Number):void 
		{
			_position.x = value;
			updatePosition();
		}
		
		override public function get y():Number { return super.y; }
		
		override public function set y(value:Number):void 
		{
			_position.y = value;
			updatePosition();
		}
		
	}
	
}