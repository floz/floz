
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
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TileIso( size:int ) 
		{
			super( size );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function build():void 
		{
			var p1:Point3D = IsoMath.isoToScreen( _size, 0 );
			var p2:Point3D = IsoMath.isoToScreen( _size, _size );
			var p3:Point3D = IsoMath.isoToScreen( 0, _size );
			
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle( 1, 0x000000, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER );
			g.beginFill( _color, .2 );
			g.moveTo( 0, 0 );
			g.lineTo( p1.x, p1.y );
			g.lineTo( p2.x, p2.y );
			g.lineTo( p3.x, p3.y );
			g.lineTo( 0, 0 );
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