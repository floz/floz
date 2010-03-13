
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import fr.tilzy.utils.MapDatasConverter;
	import fr.tilzy.isometric.IsoWorld;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const DATAS:Array = [ [ 0, 0, 0, 1 ],
									  [ 0, 0, 1, 0 ],
									  [ 0, 0, 1, 0 ],
									  [ 1, 0, 0, 0 ] ];
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			var world:IsoWorld = new IsoWorld( 32, MapDatasConverter.fromArray( DATAS ) );
			world.showGrid = true;
			addChild( world );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}