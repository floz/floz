package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class Random1 extends Sprite
	{
		private var numDots:uint = 50;
		
		public function Random1()
		{
			init();
		}
		
		private function init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			for(var i:uint = 0; i < numDots; i++)
			{
				var dot:Ball = new Ball(1, 0);
				dot.x = stage.stageWidth / 2 + Math.random() * 200 - 100;
				dot.y = stage.stageHeight / 2 + Math.random() * 200 - 100;
				addChild(dot);
			}
		}
	}
}
