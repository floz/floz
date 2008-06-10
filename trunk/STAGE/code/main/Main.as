package main 
{
	import five3D.display.Scene3D;
	import five3D.display.Sprite3D;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import interfaceSite.Datas;
	import interfaceSite.Feuille;
	import interfaceSite.Menu;
	import interfaceSite.rubriques.Introduction;
	
	public class Main extends MovieClip 
	{
		public const VERT:uint = 0x0c6c83;
		public const BLEU:uint = 0x59b26d;
		
		private var scene:Scene3D;
		private var container:Sprite3D;
		private var datas:Datas;
		
		private var _rubriques:Array;
		private var _projets:Array;		
		private var menu:Menu;
		
		public function Main() 
		{
			var m:Matrix = new Matrix( 1, 0, 0, 1, stage.stageWidth/2, stage.stageHeight );
			var background:Sprite = new Sprite();
			background.graphics.beginGradientFill( GradientType.RADIAL, [ BLEU, VERT ], [ .8, .8 ], [ 0, 255 ], m );
			background.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			background.graphics.endFill();
			addChild( background );
			
			scene = new Scene3D();
			scene.x = stage.stageWidth / 2;
			scene.y = stage.stageHeight / 2;
			addChild( scene );
			
			container = new Sprite3D();
			scene.addChild( container );
			
			scene.filters = [ new DropShadowFilter( 0, 0, 0x000000, 1, 1.5, 1.5, 3, 3 ) ];
			
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMove );
			
			datas = new Datas( "inc/rubriques.xml" );
			datas.addEventListener( Datas.COMPLETE, onDatasComplete );
			
			datas.load();
			
			stage.addEventListener( Event.RESIZE, onResize );
		}
		
		// EVENTS
		
		private function onMove(e:MouseEvent):void 
		{
			if ( e.stageX > 0 && e.stageX < stage.stageWidth && e.stageY > 0 && e.stageY < stage.stageHeight );
		}
		
		private function onResize(e:Event):void 
		{
			scene.x = stage.stageWidth / 2;
			scene.y = stage.stageHeight / 2 ;
			
			menu.x = -stage.stageWidth / 2;
			menu.y = -stage.stageHeight / 2;
		}
		
		private function onDatasComplete(e:Event):void 
		{
			_rubriques = datas.getRubs();
			_projets = datas.getProjs();
			
			menu = new Menu( 0x000000 );
			menu.x = -stage.stageWidth / 2;
			menu.y = -stage.stageHeight / 2;
			menu.addEventListener( Menu.SELECT, onMenuSelect );
			scene.addChild( menu );
		}
		
		private function onMenuSelect(e:Event):void 
		{
			var s:Sprite3D;
			if ( menu.selected == _rubriques[ 0 ] )
			{
				trace (_rubriques[0]);
				trace( "container.numChildren : " + container.numChildren );
				while ( container.numChildren ) container.removeChildAt( 0 );
				trace( "container.numChildren : " + container.numChildren );
				
				s = new Introduction();
				container.addChild( s );
			} else if ( menu.selected == _rubriques[ 1 ] )
			{
				trace (_rubriques[1]);
				while ( container.numChildren ) container.removeChildAt( 0 );
			} else if ( menu.selected == _rubriques[ 2 ] )
			{
				trace (_rubriques[2]);
				while ( container.numChildren ) container.removeChildAt( 0 );
			} else if ( menu.selected == _rubriques[ 3 ] )
			{
				trace (_rubriques[3]);
				while ( container.numChildren ) container.removeChildAt( 0 );
			} else if ( menu.selected == _rubriques[ 4 ] )
			{
				trace (_rubriques[4]);
				while ( container.numChildren ) container.removeChildAt( 0 );
			} else if ( menu.selected == _rubriques[ 5 ] )
			{
				trace (_rubriques[5]);
				while ( container.numChildren ) container.removeChildAt( 0 );
			}
		}
		
		// GETTERS & SETTERS
		
		public function get rubriques():Array { return _rubriques; }
		
		public function get projets():Array { return _projets; }
		
	}
	
}