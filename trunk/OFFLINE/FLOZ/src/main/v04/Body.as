
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v04 
{
	import com.as3dmod.modifiers.Bend;
	import com.as3dmod.ModifierStack;
	import com.as3dmod.plugins.pv3d.LibraryPv3d;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	
	public class Body extends DisplayObject3D
	{
		private var head:Plane;
		private var chest:Plane;
		private var rightArm:Plane;
		private var leftArm:Plane;
		private var leftLeg:Plane;
		private var rightLeg:Plane;
		
		private var modifierHead:ModifierStack;
		private var modifierChest:ModifierStack;
		private var modifierRightArm:ModifierStack;
		private var modifierLeftArm:ModifierStack;
		private var modifierRightLeg:ModifierStack;
		private var modifierLeftLeg:ModifierStack;
		private var bendBody:Bend;
		private var bendHead:Bend;
		private var bendChest:Bend;
		private var bendLeftArm:Bend;
		private var bendRightArm:Bend;
		private var bendLeftLeg:Bend;
		private var bendRightLeg:Bend;
		
		private var _added:Boolean;
		
		public function Body() 
		{
			super();
			
			build();			
			initModifiers();
		}
		
		// EVENTS
		
		private function initModifiers():void 
		{
			modifierHead = new ModifierStack( new LibraryPv3d(), head );
			modifierChest = new ModifierStack( new LibraryPv3d(), chest );
			modifierRightArm = new ModifierStack( new LibraryPv3d(), rightArm );
			modifierLeftArm = new ModifierStack( new LibraryPv3d(), leftArm );
			modifierRightLeg = new ModifierStack( new LibraryPv3d(), rightLeg );
			modifierLeftLeg = new ModifierStack( new LibraryPv3d(), leftLeg );
			
			bendHead = new Bend( Model.forceHead, Model.offsetHead );
			bendChest = new Bend( Model.forceChest, Model.offsetChest );
			bendLeftArm = new Bend( Model.forceLeftArm, Model.offsetLeftArm );
			bendRightArm = new Bend( Model.forceRightArm, Model.offsetRightArm );
			bendLeftLeg = new Bend( Model.forceLeftLeg, Model.offsetLeftLeg );
			bendRightLeg = new Bend( Model.forceRightLeg, Model.offsetRightLeg );
			
			modifierHead.addModifier( bendHead );
			modifierChest.addModifier( bendChest );
			modifierLeftArm.addModifier( bendLeftArm );
			modifierRightArm.addModifier( bendRightArm );
			modifierLeftLeg.addModifier( bendLeftLeg );
			modifierRightLeg.addModifier( bendRightLeg );
			
			applyNewAxes();
			_added = true;
		}
		
		// PRIVATE
		
		private function configureModifier():void
		{
			modifierHead.clear();
			modifierChest.clear();
			modifierLeftArm.clear();
			modifierRightArm.clear();
			modifierLeftLeg.clear();
			modifierRightLeg.clear();
			
			modifierHead = null;
			modifierChest = null;
			modifierRightArm = null;
			modifierLeftArm = null;
			modifierRightLeg = null;
			modifierLeftLeg = null;
			
			modifierHead = new ModifierStack( new LibraryPv3d(), head );
			modifierChest = new ModifierStack( new LibraryPv3d(), chest );
			modifierRightArm = new ModifierStack( new LibraryPv3d(), rightArm );
			modifierLeftArm = new ModifierStack( new LibraryPv3d(), leftArm );
			modifierRightLeg = new ModifierStack( new LibraryPv3d(), rightLeg );
			modifierLeftLeg = new ModifierStack( new LibraryPv3d(), leftLeg );
			
			modifierHead.addModifier( bendHead );
			modifierChest.addModifier( bendChest );
			modifierLeftArm.addModifier( bendLeftArm );
			modifierRightArm.addModifier( bendRightArm );
			modifierLeftLeg.addModifier( bendLeftLeg );
			modifierRightLeg.addModifier( bendRightLeg );			
		}
		
		// PUBLIC
		
		public function build():void
		{
			var bd:BitmapData = new BmpHead( 0, 0 );
			var m:BitmapMaterial = new BitmapMaterial( bd );
			m.oneSide = false;
			
			head = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			head.y = -bd.height * .5;
			addChild( head );
			
			bd = new BmpChest( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			var chestWidth:Number = bd.width;
			var chestHeight:Number = bd.height;
			chest = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			chest.y = head.y * 2 - bd.height * .5;			
			addChild( chest );
			
			bd = new RightArm( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			rightArm = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			rightArm.x = -chestWidth * .5 - bd.width * .5;
			rightArm.y = chest.y - bd.height / 4;
			addChild( rightArm );
			
			bd = new LeftArm( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			leftArm = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			leftArm.x = chestWidth * .5 + bd.width * .5;
			leftArm.y = rightArm.y;
			addChild( leftArm );
			
			bd = new LeftLeg( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			leftLeg = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			leftLeg.y = chest.y - chestHeight * .5 - bd.height * .5;
			leftLeg.x = bd.width * .5;
			addChild( leftLeg );
			
			bd = new RightLeg( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			rightLeg = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			rightLeg.y = chest.y - chestHeight * .5 - bd.height * .5;
			rightLeg.x = -bd.width * .5;
			addChild( rightLeg );
		}
		
		public function destroy():void
		{
			removeChild( head );
			head = null;
			removeChild( chest );
			chest = null;
			removeChild( leftArm );
			leftArm = null;
			removeChild( rightArm );
			rightArm = null;
			removeChild( leftLeg );
			leftLeg = null;
			removeChild( rightLeg );
			rightLeg = null;
		}
		
		public function rebuild():void
		{
			destroy();
			build();
			configureModifier();
		}
		
		public function applyNewForce():void
		{
			if ( bendHead.force != Model.forceHead ) bendHead.force = Model.forceHead;
			if ( bendChest.force != Model.forceChest ) bendChest.force = Model.forceChest;
			if ( bendLeftArm.force != Model.forceLeftArm ) bendLeftArm.force = Model.forceLeftArm;
			if ( bendRightArm.force != Model.forceRightArm ) bendRightArm.force = Model.forceRightArm;
			if ( bendLeftLeg.force != Model.forceLeftLeg ) bendLeftLeg.force = Model.forceLeftLeg;
			if ( bendRightLeg.force != Model.forceRightLeg ) bendRightLeg.force = Model.forceRightLeg;
		}
		
		public function applyNewOffset():void
		{
			if ( bendHead.offset != Model.offsetHead ) bendHead.offset = Model.offsetHead;
			if ( bendChest.offset != Model.offsetChest ) bendChest.offset = Model.offsetChest;
			if ( bendLeftArm.offset != Model.offsetLeftArm ) bendLeftArm.offset = Model.offsetLeftArm;
			if ( bendRightArm.offset != Model.offsetRightArm ) bendRightArm.offset = Model.offsetRightArm;
			if ( bendLeftLeg.offset != Model.offsetLeftLeg ) bendLeftLeg.offset = Model.offsetLeftLeg;
			if ( bendRightLeg.offset != Model.offsetRightLeg ) bendRightLeg.offset = Model.offsetRightLeg;
		}
		
		public function applyNewAxes():void
		{
			bendHead.bendAxis = Model.axeHead;
			bendChest.bendAxis = Model.axeChest;
			bendLeftArm.bendAxis = Model.axeLeftArm;
			bendRightArm.bendAxis = Model.axeRightArm;
			bendLeftLeg.bendAxis = Model.axeLeftLeg;
			bendRightLeg.bendAxis = Model.axeRightLeg;
		}
		
		public function applyModifiers():void
		{
			if ( !_added ) return;
			
			modifierHead.apply();
			modifierChest.apply();
			modifierLeftArm.apply();
			modifierRightArm.apply();
			modifierLeftLeg.apply();
			modifierRightLeg.apply();
		}
		
	}
	
}