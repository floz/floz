
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import maps.builders.Map2DBuilder;
	import maps.IMap;
	import maps.Map;
	
	public class Main02 extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _map:/*Array*/Array = [ [ 0, 0, 0, 1, 0 ],
											[ 0, 1, 0, 0, 1 ],
											[ 0, 1, 1, 0, 1 ],
											[ 0, 1, 0, 0, 0 ],
											[ 1, 0, 0, 0, 0 ] ];
		
		private var _normalMap:Map;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main02() 
		{
			_normalMap = new Map( new Map2DBuilder(), _map );
			addChild( _normalMap );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}