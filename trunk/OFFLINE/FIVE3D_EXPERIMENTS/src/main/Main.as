
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import five3D.display.Bitmap3D;
	import five3D.display.Scene3D;
	import five3D.display.Sprite3D;
	import five3D.geom.Point3D;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import gs.easing.Back;
	import gs.easing.Cubic;
	import gs.easing.Expo;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Main extends MovieClip
	{
		private var sprite:Sprite3D;
		private var timer:Number = .4;
		
		public function Main() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var scene:Scene3D = new Scene3D();
			scene.x = stage.stageWidth * .5
			scene.y = stage.stageHeight * .5
			addChild( scene );
			
			var normalSprite:NormalSprite = new NormalSprite();
			normalSprite.x = 350;
			normalSprite.y = 200;
			addChild( normalSprite );
			normalSprite.addEventListener( MouseEvent.CLICK, onClick );
			
			var bd:BitmapData = new BitmapData( normalSprite.width, normalSprite.height, true, 0x00000000 );
			bd.draw( normalSprite, new Matrix( 1, 0, 0, 1, normalSprite.width * .5, normalSprite.height * .5 ) );
			
			var b3D:Bitmap3D = new Bitmap3D( bd, true );
			b3D.x = -bd.width * .5;
			b3D.y = -bd.height * .5;
			
			var fiveSprite:Sprite3D = new Sprite3D();
			fiveSprite.addChild( b3D );
			fiveSprite.x = -100;
			fiveSprite.y = 0;
			scene.addChild( fiveSprite );
			fiveSprite.addEventListener( MouseEvent.CLICK, onClickS3D );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			TweenLite.to( e.currentTarget, timer, { scaleX: e.currentTarget.scaleX * -1, ease: Back.easeInOut } );
		}
		
		private function onClickS3D(e:MouseEvent):void 
		{
			//TweenLite.to( e.currentTarget, timer, { rotationY: e.currentTarget.rotationY + 180, ease: Quad.easeOut } );
			TweenLite.to( e.currentTarget, timer, { rotationY: e.currentTarget.rotationY + 180, ease: Back.easeOut } );
		}
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}