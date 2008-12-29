package 
{
	import caurina.transitions.Tweener;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Floz - Florian Zumbrunn
	 */
	public class Main extends Sprite 
	{
		private var b:Bulle;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			b = new Bulle();
			b.x = stage.stageWidth * .5;
			b.y = stage.stageHeight * .5;
			addChild( b );
			
			b.appear();
			
			b.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			b.addEventListener( MouseEvent.MOUSE_OUT, onOut );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			b.enlarge();
		}
		
		private function onOut(e:MouseEvent):void 
		{
			b.normalize();
		}
		
	}
	
}