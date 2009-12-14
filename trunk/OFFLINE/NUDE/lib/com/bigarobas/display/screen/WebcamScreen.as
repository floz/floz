package com.bigarobas.display.screen {
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Camera;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class WebcamScreen extends VideoScreen{
		private var _camera:Camera;
		private var _cameraRate:int = 10;
		private var _timer:Timer;
		public function WebcamScreen(vWidth:Number=120,vHeight:Number=60,vCamID:int=0,vRate:int=10) {
			super(vWidth, vHeight);
			_cameraRate = vRate;
			width = vWidth;
			height = vHeight;
			
			_timer = new Timer( 1000 / _cameraRate );
			_timer.addEventListener(TimerEvent.TIMER, renderCamera);
			_timer.start(); 
			
			var names:Array = Camera.names;
			_camera = Camera.getCamera(String(vCamID));
			_camera.setMode(vWidth, vHeight, _cameraRate,true);
			_camera.setQuality(0, 100);
			_video.attachCamera(_camera);
			_video.scaleX = -1;
			_video.x = vWidth;
			
			_camera.addEventListener(ActivityEvent.ACTIVITY, onCamActiv);
			
			
		}
		
		private function onCamActiv(e:ActivityEvent):void {
			addChild(_video);
			_timer = new Timer( 1000 / _cameraRate );
			_timer.addEventListener(TimerEvent.TIMER, renderCamera);
			_timer.start(); 
		}
		
		private function renderCamera(e:Event):void {
			
		}
		
		public function get camera():Camera { return _camera; }
		
	}
	
}