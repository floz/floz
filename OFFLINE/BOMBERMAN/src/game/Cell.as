
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package game 
{	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import main.Const;
	
	public class Cell extends Sprite 
	{
		public var status:String;
		
		public function Cell( size:Number = 50, status:String = Const.FREE, texture:BitmapData = null ) 
		{
			this.status = status;
			
			if ( texture )
			{
				trace ("texture pas encore prise en compte");
			}
			else
			{
				var color:uint;		
				switch( status )
				{
					case Const.FREE : color = 0xFFFFFF; break;
					case Const.BLOCKED : color = 0xFF0000; break;
					case Const.DESTROYABLE : color = 0x0000FF; break;
					case Const.CONSUMABLE : color = 0x00FF00; break;
				}
				
				this.graphics.lineStyle( 0, 0x000000 );
				this.graphics.beginFill( color );
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