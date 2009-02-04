
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import com.as3dmod.modifiers.Bend;
	import com.as3dmod.modifiers.Noise;
	import com.as3dmod.modifiers.Perlin;
	import com.as3dmod.ModifierStack;
	import com.as3dmod.plugins.pv3d.LibraryPv3d;
	import com.as3dmod.util.ModConstant;
	import flash.display.MovieClip;
	import flash.events.Event;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	public class Main03 extends MovieClip 
	{
		public var panel:Panel;
		
		private var view:BasicView;
		private var material:WireframeMaterial;
		
		private var plane:Plane;
		private var mStack:ModifierStack;
		
		public function Main03() 
		{
			view = new BasicView( stage.stageWidth, stage.stageHeight, false, true, CameraType.FREE );
			addChild( view );
			
			view.camera.zoom = 100;
			view.camera.focus = 10;
			
			material = new WireframeMaterial( 0 );
			material.oneSide = false;
			
			construct();
			
			panel.addEventListener( Panel.NOISE, onNoise );
			panel.addEventListener( Panel.PERLIN, onPerlin );
			panel.addEventListener( Panel.BEND, onBend );
			panel.addEventListener( Panel.FORCE_VALUE_CHANGE, onForceChange );
			panel.addEventListener( Panel.OFFSET_VALUE_CHANGE, onOffsetChange );
			panel.addEventListener( Panel.SEGMENTS_VALUE_CHANGE, onSegmentChange );
			panel.addEventListener( Panel.AXIS_CHANGE, onBend );
		}
		
		// EVENTS
		
		private function onFrame(e:Event):void 
		{
			mStack.apply();
			view.singleRender();
		}
		
		private function onNoise(e:Event):void 
		{
			mStack.clear();			
			mStack.addModifier( new Noise( panel.force ) );
		}
		
		private function onPerlin(e:Event):void 
		{
			mStack.clear();			
			mStack.addModifier( new Perlin( panel.force ) );
		}
		
		private function onBend(e:Event):void 
		{
			var bend:Bend = new Bend( panel.force, panel.offset );
			bend.bendAxis = panel.axis;
			mStack.clear();			
			mStack.addModifier( bend );
		}
		
		private function onForceChange(e:Event):void 
		{
			switch( panel.modifier )
			{
				case Panel.NOISE: onNoise( null ); break;
				case Panel.PERLIN: onPerlin( null ); break;
				case Panel.BEND: onBend( null ); break;
			}
		}
		
		private function onOffsetChange(e:Event):void 
		{
			if ( panel.modifier == Panel.BEND ) onBend( null );
		}
		
		private function onSegmentChange(e:Event):void 
		{
			reconstruct();
		}
		
		// PRIVATE
		
		private function construct():void
		{
			plane = new Plane( material, 300, 300, panel.segmentsW, panel.segmentsH );
			view.scene.addChild( plane );
			plane.y = 70;
			plane.rotationX =
			plane.rotationY = 10;			
			
			mStack = new ModifierStack( new LibraryPv3d(), plane );
			if ( panel.modifier ) onForceChange( null );
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function destruct():void
		{
			removeEventListener( Event.ENTER_FRAME, onFrame );
			
			view.scene.removeChild( plane );
			plane = null;
			
			mStack.clear();
			mStack = null;
		}
		
		private function reconstruct():void
		{
			destruct();
			construct();
		}
		
		// PUBLIC
		
	}
	
}