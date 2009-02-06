
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v02
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gs.easing.Quad;
	import gs.TweenLite;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	public class Main extends MovieClip
	{
		private var view:BasicView;
		
		public function Main() 
		{
			initPapervision();
			initDecor();
			
			view.startRendering();
			
			TweenLite.to( view.camera, 1, { z: -500, ease: Quad.easeOut } );
			
			//addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// EVENTS
		
		//private function onFrame(e:Event):void 
		//{
			//view.camera.z+=10;
			//view.singleRender();
		//}
		
		// PRIVATE
		
		private function initPapervision():void
		{
			view = new BasicView( stage.stageWidth, stage.stageHeight, false, true, CameraType.FREE  );
			addChild( view );
			
			view.camera.zoom = 100;
			view.camera.focus = 10;
		}
		
		private function initDecor():void
		{
			var bm:BitmapMaterial = new BitmapMaterial( new BitmapData( 300, 75, false, 0xFFFFFF ) );
			bm.interactive = true;
			
			var decor:DisplayObject3D = new DisplayObject3D();
			view.scene.addChild( decor );
			
			bm = new BitmapMaterial( new BitmapData( stage.stageWidth, stage.stageHeight, false, 0xff000000 ) );
			
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight * .5 - (75 >> 1);
			
			var pDecor:Plane = new Plane( bm, w, h, 0, 0 );
			pDecor.y = h * .5 + (75 >> 1);
			decor.addChild( pDecor );
			
			pDecor = new Plane( bm, w, h, 0, 0 );
			pDecor.y = - (h * .5 + (75 >> 1));
			decor.addChild( pDecor );
			
			w = stage.stageWidth * .5 - (300 >> 1);
			h = stage.stageHeight;
			
			pDecor = new Plane( bm, w, h );
			pDecor.x = w * .5 + ( 300 >> 1 );
			decor.addChild( pDecor );
			
			pDecor = new Plane( bm, w, h );
			pDecor.x = - ( w * .5 + ( 300 >> 1 ) );
			decor.addChild( pDecor );
		}
		
		// PUBLIC
		
	}
	
}