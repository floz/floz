
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package video 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class VideoPlayer02 extends Sprite
	{
		private var connection:NetConnection;
		private var stream:NetStream;
		
		public function VideoPlayer02() 
		{
			connection = new NetConnection();
			connection.connect( null ); // a changer avec l'url du serveur (uri du serveur)
			
			stream = new NetStream( connection );
			stream.client = this;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
	class Client
	{
		public function onMetaData( infos:Object ):void
		{
			for ( var o:Object in infos ) trace ( o + " : " + infos[ o ] );
		}
		
		public function onCuePoint( infos:Object ):void
		{
			
		}
	}
	
}