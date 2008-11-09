
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package video 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import video.components.Timeline;
	
	public class VideoPlayer03 extends Sprite
	{
		public static const INFOS_LOADED:String = "infos_loaded";
		
		private var verbose:Boolean;
		private var cnt:Sprite;
		private var menu:Sprite;		
		private var connection:NetConnection;
		private var client:Client;
		private var stream:NetStream;
		
		private var vdo:Video;
		private var request:URLRequest;
		private var loader:URLLoader;
		
		private var _vWidth:Number;
		private var _vHeight:Number;
		private var _vDuration:Number;
		
		private var url:String;
		private var playAfter:Boolean;
		
		private var volume:Number = 1;
		
		private var temp:Number;
		
		public function VideoPlayer03( connectParam:String = null, verbose:Boolean = false ) 
		{
			this.verbose = verbose;
			
			cnt = new Sprite();
			addChild( cnt );
			
			menu = new Sprite();
			addChild( menu );
			
			connection = new NetConnection();
			if ( verbose ) connection.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus )
			connection.connect( connectParam );
			
			client = new Client();
			stream = new NetStream( connection );
			stream.client = client;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onNetStatus(e:NetStatusEvent):void 
		{
			trace ( "status info : " + e.info.code );
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			if ( verbose ) connection.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			
			client.removeEventListener( Event.COMPLETE, onClientComplete );
			
			if ( verbose ) stream.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			client.addEventListener( Event.COMPLETE, onClientComplete );
			
			if ( verbose ) stream.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			
			vdo = new Video();
			vdo.attachNetStream( stream );
			cnt.addChild( vdo );
			
			request = new URLRequest();
			loader = new URLLoader();
			loader.addEventListener( Event.COMPLETE, onLoadComplete );
			loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		private function onClientComplete(e:Event):void 
		{
			this._vWidth = e.currentTarget.vWidth;
			this._vHeight = e.currentTarget.vHeight;
			this._vDuration = e.currentTarget.vDuration;
		}
		
		private function onLoadComplete(e:Event):void 
		{
			dispatchEvent( new Event( VideoPlayer03.INFOS_LOADED ) );
			
			if ( playAfter ) play();
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace ( "IOError : this link isn't correct : " + request.url );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		/**
		 * Preload la vidéo.
		 * @param	url	String	L'URL de la vidéo à jouer.
		 * @param	playAfter	Boolean	Permet de jouer la vidéo, ou non, après le chargement.
		 */
		public function preload( url:String = null, playAfter:Boolean = false ):void
		{
			if ( url ) this.url = url;
			if ( !this.url ) 
			{
				throw new Error( "There is no url used to preload the video. Please, attribute one. ('preload' method)" )
				return;
			}
			
			this.playAfter = playAfter;
			
			request.url = this.url;
			loader.load( request );
		}
		
		/**
		 * Joue la vidéo.
		 * @param	url	String	L'URL de la vidéo à jouer.
		 */
		public function play( url:String = null ):void
		{
			if ( url ) this.url = url;
			if ( !this.url ) 
			{
				throw new Error( "There is no URL used to play the video. Please, attribute one. ('play' method)" );
				return;				
			}
			
			stream.play( this.url );
			stream.seek( 0 );
			
			stream.soundTransform = new SoundTransform( 0 );
		}
		
		/** Met en pause la vidéo */
		public function pause():void
		{
			stream.pause();
		}
		
		/** Relance la vidéo. */
		public function resume():void
		{
			stream.resume();
		}
		
		/** Stop la vidéo, et ferme les connexions à celle ci. */
		public function close():void // stop() ? 
		{
			stream.close();
		}
		
		public function mute():void
		{
			stream.soundTransform = new SoundTransform( 0 );
		}
		
		public function unmute():void
		{
			stream.soundTransform = new SoundTransform( volume );
		}
		
		/**
		 * Permet d'aller à un temps T de la vidéo.
		 * @param	second	int	L'instant de la vidéo en secondes auquel nous voulons accéder.
		 */
		public function toSecond( second:int ):void
		{
			stream.seek( second );
		}
		
		// GETTERS & SETTERS
		
		/** The real video width */
		public function get vWidth():Number { return _vWidth; }
		
		/** The real video height */
		public function get vHeight():Number { return _vHeight; }
		
		/** The video duration */	
		public function get vDuration():Number { return _vDuration; }
	}
}

//

import flash.events.Event;
import flash.events.EventDispatcher;
	
class Client extends EventDispatcher
{
	public var vWidth:Number;
	public var vHeight:Number;
	public var vDuration:Number;
	
	public function onMetaData( infos:Object ):void
	{
		//for ( var o:Object in infos ) trace ( o + " : " + infos[ o ] );
		
		vWidth = infos.width;
		vHeight = infos.height;
		vDuration = infos.duration;
		
		dispatchEvent( new Event( Event.COMPLETE ) );
	}
	
	public function onCuePoint( infos:Object ):void
	{
		trace( "Client.onCuePoint > infos : " + infos );			
	}
}