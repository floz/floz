
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
		
		private var aX:Number;
		private var aY:Number;
		private var coef:Number;
		private var pressed:Boolean;
		
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
			aX = e.stageX + body.rotationY;
			coef = Math.cos( body.rotationY * Math.PI / 180 );
			aY = coef > 0 ? e.stageY + body.rotationX : e.stageY - body.rotationX;
			
			pressed = true;
			
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
		}
		
		private function onUp(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, onUp );
			
			pressed = false;
		}
		
		private function onFrame(e:Event):void 
		{
			modifiersHead.apply();
			modifiersChest.apply();
			modifiersLeftArm.apply();
			modifiersRightArm.apply();
			modifiersLeftLeg.apply();
			modifiersRightLeg.apply();
			
			if ( pressed )
			{
				body.rotationY = ( aX - stage.mouseX );
				coef = Math.cos( body.rotationY * Math.PI / 180 );
				body.rotationX = ( aY - stage.mouseY ) * coef;
			}
			
			singleRender();
		}
		
		// PRIVATE
		
		private function createModifiers():void
		{
			modifiersHead = 
			modifiersChest =
			modifiersLeftArm = 
			modifiersRightArm =
			modifiersLeftArm =
			modifiersRightLeg =	null;
			
			modifiersHead = new ModifierStack( new LibraryPv3d(), body.head );
			modifiersChest = new ModifierStack( new LibraryPv3d(), body.chest );
			modifiersLeftArm = new ModifierStack( new LibraryPv3d(), body.leftArm );
			modifiersRightArm = new ModifierStack( new LibraryPv3d(), body.rightArm );
			modifiersLeftLeg = new ModifierStack( new LibraryPv3d(), body.leftLeg );
			modifiersRightLeg = new ModifierStack( new LibraryPv3d(), body.rightLeg );
		}
		
		// PUBLIC
		
		public function refreshCurrentPart():void
		{
			var indexPart:int = Model.currentPart.data
			var part:Object = Model.listParts[ indexPart ]; // Model.currentPart a changer
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
		
		public function refreshAllParts():void
		{
			var mod:ModifierStack;
			
			var n:int = Model.listParts.length;
			var j:int;
			var m:int;
			for ( var i:int; i < n; i++ )
			{
				switch( i )
				{
					case 0: mod = modifiersHead; break;
					case 1: mod = modifiersChest; break;
					case 2: mod = modifiersLeftArm; break;
					case 3: mod = modifiersRightArm; break;
					case 4: mod = modifiersLeftLeg; break;
					case 5: mod = modifiersRightLeg; break;
				}
				
				m = Model.listParts[ i ].attributes.length;
				for ( j = 0; j < m; j++ )
					mod.addModifier( Model.listParts[ i ].attributes[ j ].modifier );
			}
		}
		
		public function rebuildCurrentPart():void
		{
			body.rebuildCurrentPart();
			createModifiers();
		}
		
	}
	
}