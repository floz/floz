package pv3DEarthBall 
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.papervision3d.view.BasicView;

	public class PV3DEarthBall extends BasicView
	{
		private var _earth:Earth;
		
		public function PV3DEarthBall() 
		{
			super( 640, 480 );
			var earthBmp:BitmapData = new EarthMap(0,0);
			
			_earth = new Earth( earthBmp );
			
			scene.addChild( _earth );
			camera.fov = 30;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
		}
		
		private function onFrame(e:Event):void 
		{
			_earth.update();			
			singleRender();
		}
		
		private function onDown(e:MouseEvent):void 
		{
			if ( _earth.z == 0 )
			{
				_earth.gravity = -10;
				_earth.velocity.z = 1000;
				_earth.velocity.y = 200;
				_earth.rotationY = 0;
				_earth.rotVel.x = 20;
			}
			else
			{
				_earth.reset();
			}
		}
		
	}
	
}