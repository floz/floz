
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import aze.motion.easing.Linear;
	import aze.motion.eaze;
	import com.wtf.misc.AnimatedBitmap;
	import com.wtf.misc.MovieBitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	import fr.floz.isometric.objects.mobiles.BasicChar;
	import fr.floz.isometric.objects.primitives.IsoBox;
	import fr.floz.isometric.objects.primitives.IsoRect;
	import fr.floz.isometric.scenes.IsoScene;
	import fr.minuit4.utils.debug.FPS;
	
	public class Main7 extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var scene:IsoScene;
		private var box:IsoBox;
		private var sprite:BasicChar;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main7() 
		{
			
			scene = new IsoScene( 32, stage.stageWidth, stage.stageHeight );
			scene.x = stage.stageWidth * .5;
			addChild( scene );
			
			box = new IsoBox( 32, 32, 8 );
			box.cacheAsBitmap = true;
			eaze( box ).apply( { x: 0, y: 0, z: 0 } ); // WTF BUG 
			scene.addMobile( box );
			
			initSprite();			
			addChild( new FPS() );
			
			stage.addEventListener( MouseEvent.MOUSE_DOWN, downHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function downHandler(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, upHandler, false, 0, true );
			addEventListener( Event.ENTER_FRAME, enterFrameHandler, false, 0, true );
		}
		
		private function upHandler(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, upHandler );
			removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			var p:Point3D = IsoMath.screenToIso( new Point3D( stage.mouseX - scene.x, stage.mouseY ) );
			
			var d:Point3D = new Point3D();
			d.x = int( p.x / 32 ) * 32;
			d.y = int( p.y / 32 ) * 32;
			d.z = int( p.z / 32 ) * 32;
			
			if ( d.x > 448 ) d.x = 448;
			else if ( d.x < 0 ) d.x = 0;
			
			if ( d.y > 448 ) d.y = 448;
			else if ( d.y < 0 ) d.y = 0;
			
			eaze( sprite ).to( 3, { x: d.x, y: d.y, z: d.z } );
			scene.render();
			sprite.update();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initSprite():void
		{
			sprite = new BasicChar();			
			scene.addMobile( sprite );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}