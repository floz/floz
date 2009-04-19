
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v01
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gs.easing.Quad;
	import gs.TweenLite;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	public class Main extends MovieClip
	{
		private var plane:Plane;
		private var planeUnder:Plane;
		
		public function Main() 
		{
			var view:BasicView = new BasicView( stage.stageWidth, stage.stageHeight, false, true );
			addChild( view );
			
			view.camera.zoom = 100;
			view.camera.focus = 10;
			
			var bm:BitmapMaterial = new BitmapMaterial( new BitmapData( 300, 75, false, 0xFFFFFF ) );
			bm.interactive = true;
			
			plane = new Plane( bm, 300, 75, 3 , 3 );
			plane.addEventListener( InteractiveScene3DEvent.OBJECT_CLICK, onObjectClick );
			view.scene.addChild( plane );
			
			bm = new BitmapMaterial( new BitmapData( 300, 75, false, 0x000000 ) );
			bm.interactive = true;
			bm.oneSide = false;
			
			planeUnder = new Plane( bm, 300, 75, 3, 3 );
			planeUnder.z = 100;
			view.scene.addChild( planeUnder );
			
			view.startRendering();
		}
		
		// EVENTS
		
		private function onObjectClick(e:InteractiveScene3DEvent):void 
		{
			var timer:Timer = new Timer( 300, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			timer.start();
			
			TweenLite.to( plane, .3, { rotationX: 50, ease: Quad.easeOut } );
			TweenLite.to( planeUnder, .3, { y: -120, ease: Quad.easeOut, delay: .1 } );			
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			TweenLite.to( plane, .3, { ease: Quad.easeOut, rotationX: 0, z: 100 } );
			TweenLite.to( planeUnder, .3, { z: 0, y:0, rotationX: 180, ease: Quad.easeOut } );
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}