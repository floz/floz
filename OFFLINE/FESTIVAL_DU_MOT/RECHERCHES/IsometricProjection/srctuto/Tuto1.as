
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package 
{
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.scene.IsoScene;
	import flash.display.Sprite;
	
	public class Tuto1 extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Tuto1() 
		{
			var box:IsoBox = new IsoBox();
			box.setSize( 25, 25, 0 );
			box.moveTo( 200, 200, 50 );
			
			var scene:IsoScene = new IsoScene();
			scene.hostContainer = this;
			scene.addChild( box );
			scene.render();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}