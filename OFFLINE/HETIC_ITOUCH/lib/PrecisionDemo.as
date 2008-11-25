package com.everydayflash.pv3d.precision {

	import com.everydayflash.pv3d.TopBar;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.BlendMode;
	
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.primitives.Cube;	
	import org.papervision3d.view.BasicView;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.lights.PointLight3D;
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.FilterShortcuts;
	
	import com.carlcalderon.arthropod.Debug;
	
	import flash.system.System;

	public class PrecisionDemo extends BasicView {
		
		public static const baseSize:Number = 256;
		
		private var cubeMaterial:CubeMaterial;
		private var background:Background2D;
		private var cube:Cube;
		private var topBar:TopBar;
		
		public function PrecisionDemo() {
			stage.quality = StageQuality.LOW;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			background = new Background2D();
			addChild(background);
			
			FilterShortcuts.init();

			super(stage.stageWidth, stage.stageHeight, true, true);

			background.setTile();
			initCamera();
			createCube();
			
			topBar = new TopBar("Find the chameleon cube in the center of the screen and click on it.");
			addChild(topBar);

			stage.addEventListener(Event.RESIZE, resize);
			resize(null);
			singleRender();
		}
		
		private function initCamera():void {
			// Formula: Math.abs(camera.z - obj.z) / camera.focus == camera.zoom - 1;
			// Note: obj.z is actually the z value of the plane that hold the material, 
			// so ex. for a cube a special offset is needed.
			
			// 3dobj.z = ((camera.zoom - 1) * camera.focus) - Math.abs(camera.z);
			camera.z = 800;
			camera.focus = 200;
			camera.zoom = 5;
		}

		private function createCube():void {
			cubeMaterial = new CubeMaterial();
			cubeMaterial.init(baseSize, baseSize);
			
			cube = new Cube(cubeMaterial.getList(), baseSize, baseSize, baseSize, 2, 2, 2);
			cube.z = baseSize / -2;
			cube.useOwnContainer = true;
			cube.addEventListener(InteractiveScene3DEvent.OBJECT_OVER, onCubeOver);
			cube.addEventListener(InteractiveScene3DEvent.OBJECT_OUT, onCubeOut);
			cube.addEventListener(InteractiveScene3DEvent.OBJECT_RELEASE, onCubeClick);
			scene.addChild(cube);
		}
		
		private function onCubeOver(ise:InteractiveScene3DEvent):void {
			viewport.buttonMode = true;
		}
		
		private function onCubeOut(ise:InteractiveScene3DEvent):void {
			viewport.buttonMode = false;
		}
		
		private function onCubeClick(ise:InteractiveScene3DEvent):void {
			Tweener.removeTweens(cube);
			background.changeTile(moveCube);
			cube.filters = [new GlowFilter(0x000000, .2, 24, 24, 2, 3)];
			singleRender();
		}
		
		private function moveCube():void {
			startRendering();
			var trotx:Number;
			var troty:Number;
			var trotz:Number;
			
			switch(background.currentIndex) {
				case 0:
					trotx = 0;
					troty = 0;
					trotz = 0;
					break;
				case 1:
					trotx = 0;
					troty = 180;
					trotz = 0;
					break;
				case 2:
					trotx = 0;
					troty = -90;
					trotz = 0;
					break;
				case 3:
					trotx = 0;
					troty = 90;
					trotz = 0;
					break;
				case 4:
					trotx = -90;
					troty = 0;
					trotz = 180;
					break;
				case 5:
					trotx = 90;
					troty = 0;
					trotz = 0;
					break;
			}

			Tweener.addTween(cube, { 
				rotationX:trotx, 
				rotationY:troty, 
				rotationZ:trotz,
				_Glow_alpha:0,
				transition:"easeInOutElastic", 
				time:2,
				onComplete:endMoveCube} );
		}
		
		private function endMoveCube():void {
			cube.filters = [];
			stopRendering();
		}
		
		private function resize(e:Event):void {
			topBar.resize();
			background.setTile();
			
			var screenPos:Point = new Point();
			screenPos.x = cube.screen.x + viewport.viewportWidth / 2;
			screenPos.y = cube.screen.y + viewport.viewportHeight / 2;
			
			for (var i:int = 0; i < 6; i++) {
				background.updateMaterial(screenPos, i, cubeMaterial.getBitmap(i));
			}
		}
	}
}








