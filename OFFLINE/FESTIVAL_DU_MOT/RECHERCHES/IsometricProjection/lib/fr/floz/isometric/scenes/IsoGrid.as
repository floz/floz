
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.scenes 
{
	import fr.floz.isometric.core.IsoDisplayObject;
	import fr.floz.isometric.geom.IsoDrawing;
	import fr.floz.isometric.geom.Point3D;
	
	public class IsoGrid extends IsoDisplayObject
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cellSize:Number;
		private var _width:uint;
		private var _length:uint;
		private var _height:uint;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoGrid( cellSize:Number, width:uint, length:uint ) 
		{
			this._cellSize = cellSize;
			this._width = width;
			this._length = length;
			
			drawGeometry();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function drawGeometry():void
		{
			var p:Point3D = new Point3D();
			var j:int;
			
			graphics.lineStyle( 1, 0x000000 );
			graphics.beginFill( 0x888888 );
			for ( var i:int; i < _length; ++i )
			{
				p.y = i * _cellSize;
				for ( j = 0; j < _width; ++j )
				{
					p.x = j * _cellSize;
					IsoDrawing.drawRect( graphics, _cellSize, _cellSize, 0, p );
				}
			}
			graphics.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}