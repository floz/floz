package main 
{
	import five3D.display.Scene3D;
	import five3D.display.Sprite3D;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.utils.getTimer;
	import interfaceSite.Datas;
	import interfaceSite.Feuille;
	import interfaceSite.Menu;
	import interfaceSite.Rubrique;
	import interfaceSite.rubriques.Conclusion;
	import interfaceSite.rubriques.HavasEntertainment;
	import interfaceSite.rubriques.Introduction;
	import interfaceSite.rubriques.Problematique;
	import interfaceSite.rubriques.Projets;
	import interfaceSite.rubriques.Rapport;
	
	public class Main extends MovieClip 
	{
		public const VERT:uint = 0x0c6c83;
		public const BLEU:uint = 0x59b26d;
		
		private var background:Sprite;
		private var scene:Scene3D;
		private var container:Sprite3D;
		private var datas:Datas;
		
		private var _rubriques:Array;
		private var _projets:Array;	
		private var _text:Array;
		private var menu:Menu;
		
		private var targetRotationX:Number;
		private var targetRotationY:Number;
		
		public function Main() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener( Event.RESIZE, onResize );
			
			var m:Matrix = new Matrix( 1, 0, 0, 1, stage.stageWidth/2, stage.stageHeight );
			background = new Sprite();
			background.graphics.beginGradientFill( GradientType.RADIAL, [ BLEU, VERT ], [ .8, .8 ], [ 0, 255 ], m );
			background.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			background.graphics.endFill();
			addChild( background );
			
			scene = new Scene3D();
			scene.x = stage.stageWidth / 2;
			scene.y = stage.stageHeight / 2;
			addChild( scene );
			
			container = new Sprite3D();
			container.x = -350 + 30;
			container.y = -200 + 30;
			container.rotationY = Math.random() * 10 - 5;
			container.rotationX = Math.random() * 10 - 5;
			scene.addChild( container );
			
			//scene.filters = [ new DropShadowFilter( 0, 0, 0x000000, 1, 1.5, 1.5, 3, 3 ) ];
			
			datas = new Datas( path_xml + "rubriques.xml" );
			datas.addEventListener( Datas.COMPLETE, onDatasComplete );
			
			datas.load();
		}
		
		// EVENTS
		
		private function onResize(e:Event):void 
		{
			scene.x = stage.stageWidth / 2;
			scene.y = stage.stageHeight / 2 ;
			
			menu.x = -stage.stageWidth / 2;
			menu.y = -stage.stageHeight / 2;
			
			container.x = -350 + 30;
			container.y = -200 + 30;
			
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
		}
		
		private function onDatasComplete(e:Event):void 
		{
			_rubriques = datas.getRubs();
			_projets = datas.getProjs();
			_text = datas.getTextes();
			
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
				while ( container.numChildren ) container.removeChildAt( 0 );
				
				s = new Rubrique(0);
				container.addChild( s );
				
			} else if ( menu.selected == _rubriques[ 1 ] )
			{
				while ( container.numChildren ) container.removeChildAt( 0 );
				
				s = new Rubrique(1)
				container.addChild( s );
				
			} else if ( menu.selected == _rubriques[ 2 ] )
			{
				while ( container.numChildren ) container.removeChildAt( 0 );
				
				s = new Projets();
				container.addChild( s );
				
			} else if ( menu.selected == _rubriques[ 3 ] )
			{
				while ( container.numChildren ) container.removeChildAt( 0 );
				
				s = new Rubrique(3)
				container.addChild( s );
				
			} else if ( menu.selected == _rubriques[ 4 ] )
			{
				while ( container.numChildren ) container.removeChildAt( 0 );
				
				s = new Rubrique(4)
				container.addChild( s );
				
			} else if ( menu.selected == _rubriques[ 5 ] )
			{
				while ( container.numChildren ) container.removeChildAt( 0 );
				
				s = new Rapport();
				container.addChild( s );
			}
		}
		
		// GETTERS & SETTERS
		
		public function get rubriques():Array { return _rubriques; }
		
		public function get projets():Array { return _projets; }
		
		public function get text():Array { return _text; }
		
		public function get path_xml():String
		{
			return loaderInfo.parameters[ "path_xml"] || "ressources/";
		}
		
	}
	
}