
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
	
	public class VideoPlayer extends Sprite
	{
		public static const INFOS_LOADED:String = "infos_loaded";
		public static const PLAY:String = "play";
		public static const PAUSE:String = "pause";
		public static const RESUME:String = "resume";
		public static const CLOSE:String = "close";
		public static const MUTE:String = "mute";
		public static const UNMUTE:String = "unmute";
		
		private var verbose:Boolean;	
		private var connection:NetConnection;
		private var client:Client;
		private var stream:NetStream;
		
		private var vdo:Video;
		private var sound:SoundTransform;
		private var request:URLRequest;
		private var loader:URLLoader;
		
		private var _vWidth:Number;
		private var _vHeight:Number;
		private var _vDuration:Number;
		
		private var url:String;
		private var playAfter:Boolean;
		
		private var volume:Number = 1;
		
		private var event:Event;
		private var temp:Number;
		
		public function VideoPlayer( width:Number = 320, height:Number = 240, connectParam:String = null, verbose:Boolean = false ) 
		{
			this.verbose = verbose;
			
			connection = new NetConnection();
			connection.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus )
			connection.connect( connectParam );
			
			client = new Client();
			stream = new NetStream( connection );
			stream.client = client;
			
			vdo = new Video();
			vdo.attachNetStream( stream );
			vdo.width = width;
			vdo.height = vdo.height;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onNetStatus(e:NetStatusEvent):void 
		{
			if ( verbose ) trace ( "status info : " + e.info.code );
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			connection.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			
			client.removeEventListener( Event.COMPLETE, onClientComplete );
			
			stream.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			client.addEventListener( Event.COMPLETE, onClientComplete );
			
			stream.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			
			addChild( vdo );
			
			sound = new SoundTransform( 1 );
			stream.soundTransform = sound;
			
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
			
			dispatchEvent( new Event( VideoPlayer.INFOS_LOADED ) );
		}
		
		private function onLoadComplete(e:Event):void 
		{
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
			
			stream.bufferTime = 3;
			stream.play( this.url );
			stream.seek( 0 );
			
			event = new Event( VideoPlayer.PLAY );
			dispatchEvent( event );
		}
		
		/** Met en pause la vidéo */
		public function pause():void
		{
			stream.pause();
			
			event = new Event( VideoPlayer.PAUSE );
			dispatchEvent( event );
		}
		
		/** Relance la vidéo. */
		public function resume():void
		{
			stream.resume();
			
			event = new Event( VideoPlayer.RESUME );
			dispatchEvent( event );
		}
		
		/** Stop la vidéo, et ferme les connexions à celle ci. */
		public function close():void // stop() ? 
		{
			stream.close();
			
			event = new Event( VideoPlayer.CLOSE );
			dispatchEvent( event );
		}
		
		public function mute():void
		{
			sound.volume = 0;
			stream.soundTransform = sound;
			
			event = new Event( VideoPlayer.MUTE );
			dispatchEvent( event );
		}
		
		public function unmute():void
		{
			sound.volume = volume;
			stream.soundTransform = sound;
			
			event = new Event( VideoPlayer.UNMUTE );
			dispatchEvent( event );
		}
		
		/**
		 * Permet d'aller à un temps T de la vidéo.
		 * @param	second	int	L'instant de la vidéo en secondes auquel nous voulons accéder.
		 */
		public function toSecond( second:int ):void
		{
			stream.seek( second );
		}
		
		public function resize( width:Number, Height:Number ):void
		{
			vdo.width = width;
			vdo.height = height;
		}
		
		// GETTERS & SETTERS
		
		public function get bytesPercent():Number {	return ( stream.bytesLoaded * 100 / stream.bytesTotal ) / 100; }
		
		/** The actual video time. READ ONLY */
		public function get time():Number { return stream.time; };
		
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
		for ( var o:Object in infos ) trace ( o + " : " + infos[ o ] );
		
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