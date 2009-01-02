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
		private var toolTip:ToolTip;
		private var bubbles:Bubbles;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			bubbles = new Bubbles();
			addChild( bubbles );
			
			b = new Bulle();
			b.x = stage.stageWidth * .5;
			b.y = stage.stageHeight * .5;
			addChild( b );
			
			b.appear();
			
			b.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			b.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			
			b = new Bulle( 30 );
			b.x = stage.stageWidth * .5 + b.width;
			b.y = stage.stageHeight * .5 + b.height;
			addChild( b );
			
			b.appear();
			
			b.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			b.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			
			toolTip = new ToolTip( 200, 60, 10, 0xffee1c );
			addChild( toolTip );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			toolTip.activate();			
			
			Bulle( e.currentTarget ).enlarge();
			
			Bulle( e.currentTarget ).addEventListener( MouseEvent.MOUSE_MOVE, onMove );
			bubbles.bubble( e.currentTarget.x, e.currentTarget.y );
		}
		
		private function onMove(e:MouseEvent):void 
		{
			var b:Bulle = e.currentTarget as Bulle;
			bubbles.xVel = int( e.localX / 5 );
			bubbles.yVel = int( e.localY / 5 );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			Bulle( e.currentTarget ).removeEventListener( MouseEvent.MOUSE_MOVE, onMove );
			
			toolTip.desactivate();
			Bulle( e.currentTarget ).normalize();
			bubbles.killBubbles();
		}
		
	}
	
}