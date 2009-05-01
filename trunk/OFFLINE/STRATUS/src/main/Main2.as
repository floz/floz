
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.Responder;
	import flash.system.System;
	import fr.minuit4.net.Service;
	
	public class Main2 extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main2() 
		{
			var service:Service = new Service( "http://localhost/STRATUS01/amfphp/gateway.php" );
			service.addResponder( success, fail, "fr.minuit4.net.php.HelloService.setMsg" );
			service.addResponder( success, fail, "fr.minuit4.net.php.HelloService.sayHello" );
			service.call( "fr.minuit4.net.php.HelloService.setMsg", { nom: "ARNOOB", type: "GROS PD" } );
			service.call( "fr.minuit4.net.php.HelloService.sayHello" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function success( values:* ):void
		{
			trace( "Main2.success > values : " + values );			
		}
		
		private function fail( values:* ):void
		{
			for ( var p:String in values )
			{
				trace( p + " : " + values[ p ] );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}