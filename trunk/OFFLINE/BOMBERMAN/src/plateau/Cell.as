
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package plateau 
{	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Cell extends Sprite 
	{
		/**
		 * Bonjour mix
		 * Blalblalblalblal
		 * @param	size Ca, c'est la taille
		 * @param	texture Ca c'est la texture
		 */
		public function Cell( size:Number = 50, texture:BitmapData = null ) 
		{
			if ( texture )
			{
				trace ("toto");
			}
			else
			{
				this.graphics.lineStyle( 1, 0x000000 );
				this.graphics.beginFill( 0xffffff );
				this.graphics.drawRect( 0, 0, size, size );
				this.graphics.endFill();
			}
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );	
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			
		}
		
		// PRIVATE	
		
		// PUBLIC
		
	}
	
}