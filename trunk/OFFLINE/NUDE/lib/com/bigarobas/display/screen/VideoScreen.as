package com.bigarobas.display.screen {
	import com.bigarobas.display.layer.Layer;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.sampler.NewObjectSample;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class VideoScreen extends Screen{
		protected var _video:Video;
		protected var _videoWidth:Number = 0;
		protected var _videoHeight:Number = 0;
		protected var _videoFPS:Number;
		protected var _videoDuration:Number;
		protected var _videoVolume:Number = 1;
		
		protected var _loop:Boolean = false;
		protected var _mute:Boolean = false;
		protected var _videoAutoSize:Boolean = false;
		protected var _videoAutoStart:Boolean = true;

		protected var _connection:NetConnection;
		protected var _stream:NetStream;
		protected var _listener:Object;
		
		protected var _status:Number;
		public static var PLAYING:Number = 0;
		public static var PAUSED:Number = 1;
		public static var STOPPED:Number = 2;
		
		protected var _screenShots:Array;
		protected var _screenShotsQueue:Array;
		
		// events
		public static var PLAY:String = "play";
		public static var BUFFER_FULL:String = "buffer_full";
		public static var METADATA:String = "metadata";
		public static var COMPLETE:String = "complete";
		public static var SCREENSHOTS_READY:String = "screenshots_ready";
		
		public function VideoScreen(vWidth:Number = 720, vHeight:Number = 576) {
			
			_videoWidth = vWidth;
			_videoHeight = vHeight;
			_video = new Video(_videoWidth, _videoHeight);
			addChild(_video);
			
			_connection = new NetConnection();
			_connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_connection.connect( null );
			
			_stream = new NetStream(_connection);
			_stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_video.attachNetStream(_stream);
			
			_listener = new Object();
			_listener.onMetaData = onMetaData;
			_stream.client = _listener;
			
		}
		
		public function load(vURL:String = null):void {
			_status = STOPPED;
			_stream.play(vURL);
			
		}
		
		public function resume():void {
			_stream.resume();
			_status = PLAYING;
		}
		
		public function pause():void {
			_stream.pause();
			_status = PAUSED;
		}
		
		public function close():void {
			_stream.close();
			_status = STOPPED;
		}
		
		public function jump(vSec:Number):void {
			_stream.seek(_stream.time + vSec);
		}
		
		public function seek(vSec:Number):void {
			_stream.seek(vSec);
		}
		
		public function seekRatio(vRatio:Number):void {
			seek(vRatio * _videoDuration);
		}
		
		public function getLoadedRatio():Number {
			return _stream.bytesLoaded / _stream.bytesTotal;
		}
		
		public function getPlayedRatio():Number {
			return _stream.time / _videoDuration;
		}
		
		protected function onMetaData(vMetaData:Object):void {
			
			_videoDuration = vMetaData.duration;
			_videoFPS = vMetaData.framerate;
			if (!_videoAutoStart) {
				if (_status == STOPPED) _stream.pause();
			} else {
				_stream.resume();
			}
			
			if (!_videoAutoSize) {
				setSize(_videoWidth, _videoHeight);
			} else {
				_videoWidth = vMetaData.width;
				_videoHeight = vMetaData.height;
				setSize(_videoWidth, _videoHeight);
			}
			
			dispatchEvent(new Event(METADATA));
		}
		
		protected function netStatusHandler(event:NetStatusEvent):void {
			switch(event.info.code) {
				case "NetStream.Play.Start":
					dispatchEvent(new Event(PLAY));
				break;
				case "NetStream.Play.Stop":
					if (_loop)
						_stream.seek(0);
					dispatchEvent(new Event(COMPLETE));
				break;
				case "NetStream.Buffer.Full":
					dispatchEvent(new Event(BUFFER_FULL));
				break;
			}
		}
					
		public function setSize(vWidth:Number, wHeight:Number):void {
			_video.width = vWidth;
			_video.height = wHeight;
		}
		//####################################################
		
		public function get video():Video { return _video; }
		
		public function set video(value:Video):void {
			_video = value;
		}
		
		public function get videoWidth():Number { return _videoWidth; }
		
		public function set videoWidth(value:Number):void {
			_videoWidth = value;
		}
		
		public function get videoHeight():Number { return _videoHeight; }
		
		public function set videoHeight(value:Number):void {
			_videoHeight = value;
		}
		
		public function get videoAutoSize():Boolean { return _videoAutoSize; }
		
		public function set videoAutoSize(value:Boolean):void {
			_videoAutoSize = value;
		}
		
		public function get videoAutoStart():Boolean { return _videoAutoStart; }
		
		public function set videoAutoStart(value:Boolean):void {
			_videoAutoStart = value;
		}
		
		public function get screenShots():Array { return _screenShots; }
		
		public function get status():Number { return _status; }
		
		public function get loop():Boolean { return _loop; }
		
		public function set loop(value:Boolean):void {
			_loop = value;
		}
		
		public function get stream():NetStream { return _stream; }
		
		public function get mute():Boolean { return _mute; }
		
		public function set mute(value:Boolean):void {
			if (!_mute) {
				_videoVolume = _stream.soundTransform.volume;
			}
			_mute = value;
			if (_mute) {
				_stream.soundTransform = new SoundTransform(0);
			} else {
				_stream.soundTransform = new SoundTransform(_videoVolume);
			}
			
		}
		
	}
	
}