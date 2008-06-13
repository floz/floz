package main 
{
	import caurina.transitions.Tweener;
	import five3D.display.Bitmap3D;
	import five3D.display.Scene3D;
	import five3D.display.Sprite3D;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	public class Main extends MovieClip
	{
		private var scene:Scene3D;
		private var container:Sprite3D;
		private var cRecto:Bitmap3D;
		private var cVerso:Bitmap3D;
		private var loaderRecto:Loader;
		private var requestRecto:URLRequest;
		private var requestVerso:URLRequest;
		private var loaderVerso:Loader;
		
		public function Main() 
		{
			scene = new Scene3D();
			scene.x = stage.stageWidth / 2;
			scene.y = stage.stageHeight / 2;
			addChild( scene );
			
			container = new Sprite3D();
			//container.x = - 480 / 2;
			//container.y = - 350 / 2;
			container.rotationY = 40;
			scene.addChild( container );
			
			cRecto = new Bitmap3D();
			cRecto.singleSided = true;
			cRecto.x = -480 / 2;
			cRecto.y = -350 / 2;
			container.addChild( cRecto );
			
			cVerso = new Bitmap3D();
			cVerso.singleSided = true;
			cVerso.x = 480 / 2;
			cVerso.y = -350 / 2;
			cVerso.rotationY = 180;
			container.addChild( cVerso );
			
			requestRecto = new URLRequest( "../divers/recto8.jpg" );
			loaderRecto = new Loader();
			loaderRecto.contentLoaderInfo.addEventListener( Event.COMPLETE, onRectoComplete );
			loaderRecto.load( requestRecto );
			
			requestVerso = new URLRequest( "../divers/verso8.jpg" );
			loaderVerso = new Loader();
			loaderVerso.contentLoaderInfo.addEventListener( Event.COMPLETE, onVersoComplete );
			loaderVerso.load( requestVerso );
			
			//addEventListener( Event.ENTER_FRAME, onFrame );
			
			container.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onRectoComplete(e:Event):void 
		{
			var bd:BitmapData = new BitmapData( 480, 350 );
			bd.draw( e.currentTarget.content );
			
			cRecto.bitmapData = bd;
		}
		
		private function onVersoComplete(e:Event):void 
		{
			var bd:BitmapData = new BitmapData( 480, 350 );
			bd.draw( e.currentTarget.content );
			
			cVerso.bitmapData = bd;
		}
		
		private function onFrame(e:Event):void 
		{
			container.rotationY++;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			Tweener.addTween( e.currentTarget, { rotationY: 140, time: .5, transition: "easeInOutQuad" } );
		}
		
	}
	
}