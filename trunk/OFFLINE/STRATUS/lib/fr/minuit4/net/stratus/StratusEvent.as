
/**
 * Written by :
 * @author Minuit4
 * www.minuit4.fr
 */
package fr.minuit4.net.stratus 
{
	import flash.events.Event;
	
	public class StratusEvent extends Event 
	{
		/** Diffusé lors de la connexion au service */
		public static const CONNECTION_SUCCESS:String = "stratusconnection_connect";
		
		/** Diffusé lors de l'échec de la connexion au service */
		public static const CONNECTION_FAILED:String = "stratusconnection_failed";
		
		/** Diffusé lors de la fermeture de la connexion au service */
		public static const CONNECTION_CLOSED:String = "stratusconnection_closed";
		
		/** Diffusé lors de la connexion à un nouvel utilisateur */
		public static const STREAM_SUCCESS:String = "stratusconnection_streamsuccess";
		
		/** Diffusé lors de la fermeture d'une connexion avec un utilisateur */
		public static const STREAM_CLOSED:String = "stratusconnection_streamclosed";
		
		/** Diffusé au démarrage d'une connexion */
		public static const STREAM_RESET:String = "stratusconnection_streamreset";
		
		/** Diffusé au démarrage d'une connexion */
		public static const STREAM_START:String = "stratusconnection_streamstart";
		
		public static const STREAM_PLAY_PUBLISH_START:String = "stratusconnection_streampublishstart";
		
		public function StratusEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new StratusEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("StratusEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}