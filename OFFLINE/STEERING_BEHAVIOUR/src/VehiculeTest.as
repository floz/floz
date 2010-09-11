
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class VehiculeTest extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _vehicle:Vehicle;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function VehiculeTest() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_vehicle = new Vehicle();
			addChild( _vehicle );
			
			_vehicle.position = new Vector2D( 100, 100 );
			
			_vehicle.velocity.length = 5;
			_vehicle.velocity.angle = Math.PI / 4;
			
			addEventListener( Event.ENTER_FRAME, enterFrameHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function enterFrameHandler(e:Event):void 
		{
			_vehicle.update();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}