
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package items.characters 
{
	import flash.display.BitmapData;
	
	public class Player extends Character 
	{
		
		public function Player() 
		{			
			this.graphics.beginFill( 0x0000FF );
			this.graphics.drawRect( 0, 0, 50, 65 );
			this.graphics.endFill();
		}
		
		// EVENTS
		
		// PRIVATE	
		
		// PUBLIC
		
	}
	
}