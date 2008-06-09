package main 
{
	import five3D.display.Scene3D;
	import five3D.display.Sprite3D;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import interfaceSite.Datas;
	import interfaceSite.Feuille;
	import interfaceSite.Menu;
	
	public class Main extends MovieClip 
	{
		private var scene:Scene3D;
		private var container:Sprite3D;
		private var datas:Datas;
		
		private var _rubriques:Array;
		private var _projets:Array;		
		
		public function Main() 
		{
			var m:Matrix = new Matrix( 1, 0, 0, 1, stage.stageWidth/2, stage.stageHeight/2 );
			var background:Sprite = new Sprite();
			background.graphics.beginGradientFill( GradientType.RADIAL, [ 0xFFFFFF, 0x444444 ], [ 1, 1 ], [ 0, 255 ], m );
			background.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			background.graphics.endFill();
			addChild( background );
			
			scene = new Scene3D();
			scene.x = stage.stageWidth / 2;
			scene.y = stage.stageHeight / 2;
			addChild( scene );
			
			container = new Sprite3D();
			scene.addChild( container );
			
			datas = new Datas( "inc/rubriques.xml" );
			datas.addEventListener( Datas.COMPLETE, onDatasComplete );
			
			datas.load();
			
			stage.addEventListener( Event.RESIZE, onResize );
		}
		
		private function onResize(e:Event):void 
		{
			scene.x = stage.stageWidth / 2;
			scene.y = stage.stageHeight / 2 ;
		}
		
		private function onDatasComplete(e:Event):void 
		{
			_rubriques = datas.getRubs();
			_projets = datas.getProjs();
			
			var menu:Menu = new Menu( 0x000000 );
			addChild( menu );
		}
		
		public function get rubriques():Array { return _rubriques; }
		
		public function get projets():Array { return _projets; }
		
	}
	
}