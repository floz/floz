
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.BitmapData;
	import org.papervision3d.materials.BitmapMaterial;
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
		
		public function Body() 
		{
			super( "body" );
			
			build();
		}
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
		
		public function build():void
		{
			var bd:BitmapData = new BmpHead( 0, 0 );
			var m:BitmapMaterial = new BitmapMaterial( bd );
			m.oneSide = false;
			
			head = new Plane( m, bd.width, bd.height, Main04.SEGMENTSW, Main04.SEGMENTSH );
			head.y = -bd.height * .5;
			addChild( head );
			
			bd = new BmpChest( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			var chestWidth:Number = bd.width;
			var chestHeight:Number = bd.height;
			chest = new Plane( m, bd.width, bd.height, Main04.SEGMENTSW, Main04.SEGMENTSH );
			chest.y = head.y * 2 - bd.height * .5;			
			addChild( chest );
			
			bd = new RightArm( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			rightArm = new Plane( m, bd.width, bd.height, Main04.SEGMENTSW, Main04.SEGMENTSH );
			rightArm.x = -chestWidth * .5 - bd.width * .5;
			rightArm.y = chest.y - bd.height / 4;
			addChild( rightArm );
			
			bd = new LeftArm( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			leftArm = new Plane( m, bd.width, bd.height, Main04.SEGMENTSW, Main04.SEGMENTSH );
			leftArm.x = chestWidth * .5 + bd.width * .5;
			leftArm.y = rightArm.y;
			addChild( leftArm );
			
			bd = new LeftLeg( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			leftLeg = new Plane( m, bd.width, bd.height, Main04.SEGMENTSW, Main04.SEGMENTSH );
			leftLeg.y = chest.y - chestHeight * .5 - bd.height * .5;
			leftLeg.x = bd.width * .5;
			addChild( leftLeg );
			
			bd = new RightLeg( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			rightLeg = new Plane( m, bd.width, bd.height, Main04.SEGMENTSW, Main04.SEGMENTSH );
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
		}
		
	}
	
}