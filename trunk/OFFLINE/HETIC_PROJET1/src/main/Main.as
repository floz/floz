
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import portrait.Portrait;
	
	public class Main extends MovieClip 
	{
		private var por:Portrait;
		
		public function Main() 
		{
			
		}
		
		// EVENTS
		
		// PRIVATE	
		
		// PUBLIC
		
		public function getPortrait():Bitmap
		{
			return por.getPortrait();
		}
		
	}
	
}