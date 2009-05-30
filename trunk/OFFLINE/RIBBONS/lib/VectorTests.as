
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	
	public class VectorTests extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function VectorTests() 
		{
			var v1:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>( 3, true );
			
			var v2:Vector.<uint> = Vector.<uint>( [ 0xff000000, 0xff00ff00 ] );
			var v3:Vector.<uint> = v2;
			var v4:Vector.<uint> = v3;
			
			v1[ 0 ] = v2;
			v1[ 1 ] = v3;
			v1[ 2 ] = v4;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}