
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric 
{
	
	public class DrawIsoTile extends IsoObject
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _color:uint;
		protected var _height:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DrawIsoTile( size:Number, color:uint, height:Number = 0 ) 
		{
			super( size );
			
			this._color = color;
			this._height = height;
			draw();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function draw():void
		{
			graphics.clear();
			graphics.beginFill( _color );
			graphics.lineStyle( 0, 0, .5 );
			graphics.moveTo( -size, 0 );
			graphics.lineTo( 0, -size * .5 );
			graphics.lineTo( size, 0 );
			graphics.lineTo( 0, size * .5 );
			graphics.lineTo( -size, 0 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}