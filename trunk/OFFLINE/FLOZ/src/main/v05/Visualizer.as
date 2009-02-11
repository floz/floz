
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	import com.as3dmod.ModifierStack;
	import com.as3dmod.plugins.pv3d.LibraryPv3d;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.view.BasicView;
	
	public class Visualizer extends BasicView
	{
		private var body:Body;
		
		private var modifiersHead:ModifierStack;
		private var modifiersChest:ModifierStack;
		private var modifiersLeftArm:ModifierStack;
		private var modifiersRightArm:ModifierStack;
		private var modifiersLeftLeg:ModifierStack;
		private var modifiersRightLeg:ModifierStack;
		
		public function Visualizer() 
		{
			super( this.width, this.height, false, true, CameraType.FREE );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			camera.zoom = 100;
			camera.focus = 10;
			
			body = new Body();
			scene.addChild( body );
			
			createModifiers();
			
			addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onDown(e:MouseEvent):void 
		{
			//rotation
		}
		
		private function onFrame(e:Event):void 
		{
			modifiersHead.apply();
			modifiersChest.apply();
			modifiersLeftArm.apply();
			modifiersRightArm.apply();
			modifiersLeftLeg.apply();
			modifiersRightLeg.apply();
			
			singleRender();
		}
		
		// PRIVATE
		
		private function createModifiers():void
		{
			modifiersHead = new ModifierStack( new LibraryPv3d(), body.head );
			modifiersChest = new ModifierStack( new LibraryPv3d(), body.chest );
			modifiersLeftArm = new ModifierStack( new LibraryPv3d(), body.leftArm );
			modifiersRightArm = new ModifierStack( new LibraryPv3d(), body.rightArm );
			modifiersLeftLeg = new ModifierStack( new LibraryPv3d(), body.leftLeg );
			modifiersRightLeg = new ModifierStack( new LibraryPv3d(), body.rightLeg );
		}
		
		// PUBLIC
		
		public function refresh():void
		{
			var indexPart:int = Model.currentPart.data
			var part:Object = Model.listParts[ indexPart ];
			var attributes:Array = part.attributes;
			
			var m:ModifierStack;
			switch( part.label )
			{
				case "Head": m = modifiersHead; break;
				case "Chest": m = modifiersChest; break;
				case "LeftArm": m = modifiersLeftArm; break;
				case "RightArm": m = modifiersRightArm; break;
				case "LeftLeg": m = modifiersLeftLeg; break;
				case "RightLeg": m = modifiersRightLeg; break;
			}
			
			m.clear();
			
			var n:int = attributes.length;
			for ( var i:int; i < n; i++ )
				m.addModifier( attributes[ i ].modifier );			
		}
		
	}
	
}