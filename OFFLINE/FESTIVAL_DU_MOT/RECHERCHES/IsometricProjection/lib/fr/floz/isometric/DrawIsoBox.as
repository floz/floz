
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric 
{
	
	public class DrawIsoBox extends DrawIsoTile
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DrawIsoBox( size:Number, color:uint, height:Number = 0 ) 
		{
			super( size, color, height );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function draw():void 
		{
			graphics.clear();
			
			var r:uint = _color >> 16;
			var g:uint = _color >> 8 & 0xff;
			var b:uint = _color & 0xff;
			
			var leftShadow:uint = ( r * .5 ) << 16 | ( g * .5 ) << 8 | ( b * .5 );
			var rightShadow:uint = ( r * .75 ) << 16 | ( g * .75 ) << 8 | ( b * .75 );
			
			var h:Number = _height * UIso.Y_CORRECT;
			
			graphics.beginFill( _color );
			graphics.lineStyle( 0, 0, .5 );
			graphics.moveTo( -size, -h );
			graphics.lineTo( 0, -size * .5 - h );
			graphics.lineTo( size, -h );
			graphics.lineTo( 0, size * .5 - h );
			graphics.lineTo( -size, -h );
			graphics.endFill();
			
			graphics.beginFill( leftShadow );
			graphics.lineStyle( 0, 0, .5 );
			graphics.moveTo( -size, -h );
			graphics.lineTo( 0, size * .5 - h );
			graphics.lineTo( 0, size * .5 );
			graphics.lineTo( -size, 0 );
			graphics.lineTo( -size, -h );
			graphics.endFill();
			
			graphics.beginFill( rightShadow );
			graphics.lineStyle( 0, 0, .5 );
			graphics.moveTo( size, -h );
			graphics.lineTo( 0, size * .5 - h );
			graphics.lineTo( 0, size * .5 );
			graphics.lineTo( size, 0 );
			graphics.lineTo( size, -h );
			graphics.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}