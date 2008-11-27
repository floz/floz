package {
	import flash.events.Event;
	import flash.display.Sprite;
	import fl.video.FLVPlayback;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;

	public class FLVPlayer extends MovieClip {

		//---- Variables
		private var url:String = "video/video_caracteristique.flv";


		//---- Public
		public function FLVPlayer() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function load( url:String ):void {
			player.play( url );
		}
		//---- Private
		private function onAddedToStage(e:Event) {
			player.load(url);
			player.autoPlay = false;
			player.bufferTime = 5;
			player.width = 274;
			player.height = 155;
			player.skinAutoHide = true;
		}
		
		private function removedToStage(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedToStage);
		}
	}
}