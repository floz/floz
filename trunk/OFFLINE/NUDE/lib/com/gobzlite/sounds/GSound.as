package com.gobzlite.sounds 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * Play sound easy
	 * @author DavidRonai
	 */
	public class GSound extends EventDispatcher
	{
		private var sound:Sound;
		private var channel:SoundChannel;
		
		private var _url:String;
		private var _position:Number;
		private var _volume:Number;
		
		public function GSound( url:String = "" ) 
		{
			sound = new Sound();
			_position = 0;
			_volume = SoundManager.volume;
			_url = url;
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		// load sound
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		
		/**
		 * Load the sound
		 * @param	url url to load sound
		 */
		public function load( url:String="" ):void
		{
			if ( url != "" )
				_url = url;
			sound.addEventListener(Event.COMPLETE, loadCompleteHandler);
			sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			sound.load( new URLRequest( _url ) );
		}
		private function progressHandler(e:ProgressEvent):void 
		{
			dispatchEvent( e );
		}
		private function loadCompleteHandler(e:Event):void 
		{
			sound.removeEventListener(Event.COMPLETE, loadCompleteHandler);
			sound.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatchEvent( e );
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		// play, stop, resume
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		
		/**
		 * Play a sound
		 * @param	startTime start position 
		 * @param	loops number of loops , -1 to loops infiny
		 */
		public function play(startTime:Number = 0, loops:int = 1):void
		{
			if ( loops == -1 )
				loops = int.MAX_VALUE;

			channel = sound.play( startTime, loops );
			if ( channel == null )
				return;
			
			channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			
			if ( _volume >= 0 )
				volume = _volume;
			
			else
				volume = SoundManager.volume;
		}
		
		private function onSoundComplete(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		/**
		 * Stop sound. Position is save, use resume function to relunch sound at same position
		 */
		public function stop():void
		{
			if( channel){
				channel.stop();
				_position = channel.position;
			} else {
				_position = 0;
			}
		}
		
		/**
		 * Restart sound where he was stop
		 * @param	loops number of loops, -1 to loops infiny
		 */
		public function resume( loops:int = 1 ):void
		{
			play( _position, loops );
		}
		
		/**
		 * Clear GSound memory
		 */
		public function dispose():void
		{
			stop();
			channel = null;
			sound = null;
		}
		
		/**
		 * return id3 information
		 */
		public function get id3():ID3Info
		{
			return sound.id3;
		}
		
		/**
		 * return position actually played
		 */
		public function get position():Number { return channel.position; }
		public function set position(value:Number):void 
		{
			_position = value;
		}
		
		/**
		 * return total sound length
		 */
		public function get length():Number { return sound.length; }
		
		/**
		 * get & set volume
		 */
		public function get volume():Number { 
			if( channel )
				return channel.soundTransform.volume; 
			return _volume;
		}		
		public function set volume(value:Number):void 
		{
			_volume = value;
			if( channel ){
				var control:SoundTransform = channel.soundTransform;
				control.volume = value;
				channel.soundTransform = control;
			}
		}
	}
}