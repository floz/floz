
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.tiles 
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	
	public class IsoTile extends Tile
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoTile( size:int ) 
		{
			super( size );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		final override protected function build():void 
		{
			var c:uint;
			if ( _selected && !_walkable ) c = 0x009999;
			else if ( _selected && _walkable ) c = 0x002222;
			else if ( !_selected && _walkable ) c = 0x444444;
			else c = 0xeeeeee;
			
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle( 1, 0x000000, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER );
			g.beginFill( c );
			g.moveTo( 0, 0 );
			var p:Point3D = IsoMath.isoToScreen( new Point3D( _size, 0 ) );
			g.lineTo( p.x, p.y );
			p = IsoMath.isoToScreen( new Point3D( _size, _size ) );
			g.lineTo( p.x, p.y );
			p = IsoMath.isoToScreen( new Point3D( 0, _size ) );
			g.lineTo( p.x, p.y );
			g.lineTo( 0, 0 );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}