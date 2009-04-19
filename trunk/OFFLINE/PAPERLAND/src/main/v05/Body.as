
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05
{
	import flash.display.BitmapData;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	
	public class Body extends DisplayObject3D
	{
		private var _head:Plane;
		private var _chest:Plane;
		private var _rightArm:Plane;
		private var _leftArm:Plane;
		private var _rightLeg:Plane;
		private var _leftLeg:Plane;
		
		private var _height:Number;
		
		public function Body() 
		{
			super();
			
			createBody();
			place();
		}
		
		// EVENTS
		
		// PRIVATE
		
		private function createBody():void
		{
			_height = 0;
			var bd:BitmapData = new BmpHead( 0, 0 );
			var m:BitmapMaterial = new BitmapMaterial( bd );
			m.oneSide = false;
			
			_head = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			_head.y = -bd.height * .5;
			_head.name = this.numChildren.toString();
			addChild( _head );
			
			_height += bd.height;
			
			bd = new BmpChest( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			var chestWidth:Number = bd.width;
			var chestHeight:Number = bd.height;
			_chest = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			_chest.y = _head.y * 2 - bd.height * .5;		
			_chest.name = this.numChildren.toString();
			addChild( _chest );
			
			_height += bd.height;
			
			bd = new LeftArm( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			_leftArm = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			_leftArm.x = chestWidth * .5 + bd.width * .5;
			_leftArm.y = _chest.y - bd.height / 4;
			_leftArm.name = this.numChildren.toString();
			addChild( _leftArm );
			
			bd = new RightArm( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			_rightArm = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			_rightArm.x = -chestWidth * .5 - bd.width * .5;
			_rightArm.y = _chest.y - bd.height / 4;
			_rightArm.name = this.numChildren.toString();
			addChild( _rightArm );
			
			bd = new LeftLeg( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			_leftLeg = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			_leftLeg.y = _chest.y - chestHeight * .5 - bd.height * .5;
			_leftLeg.x = bd.width * .5;
			_leftLeg.name = this.numChildren.toString();
			addChild( _leftLeg );
			
			_height += bd.height;
			
			bd = new RightLeg( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			_rightLeg = new Plane( m, bd.width, bd.height, Model.segmentsW, Model.segmentsH );
			_rightLeg.y = _chest.y - chestHeight * .5 - bd.height * .5;
			_rightLeg.x = -bd.width * .5;
			_rightLeg.name = this.numChildren.toString();
			addChild( _rightLeg );
		}
		
		private function place():void
		{
			var n:int = this.numChildren;
			for ( var i:int; i < n; i++ )
			{
				this.getChildByName( i.toString() ).y += this._height * .5;
				Model.listParts[ i ].plane = this.getChildByName( i.toString() );
				Model.listParts[ i ].x = this.getChildByName( i.toString() ).x
				Model.listParts[ i ].y = this.getChildByName( i.toString() ).y
				Model.listParts[ i ].z = this.getChildByName( i.toString() ).z
			}
		}
		
		// PUBLIC
		
		public function rebuildCurrentPart():void
		{
			var p:Plane;
			var m:BitmapMaterial;
			var n:int = this.numChildren;
			for ( var i:int; i < n; i++ )
			{
				m = Model.listParts[ i ].plane.material;
				p = new Plane( m, m.bitmap.width, m.bitmap.height, Model.listParts[ i ].segmentsW, Model.listParts[ i ].segmentsH );
				p.x = Model.listParts[ i ].x;
				p.y = Model.listParts[ i ].y;
				p.z = Model.listParts[ i ].z;
				p.rotationX = Model.listParts[ i ].rx;
				p.rotationY = Model.listParts[ i ].ry;
				p.rotationZ = Model.listParts[ i ].rz;
				p.name = i.toString();
				
				removeChild( Model.listParts[ i ].plane );
				addChild( p );
				Model.listParts[ i ].plane = p;
			}
		}
		
		// GETTERS & SETTERS
		
		public function get height():Number { return this._height; }
		
		public function get head():Plane { return Model.listParts[ 0 ].plane; }
		public function get chest():Plane { return Model.listParts[ 1 ].plane; }
		public function get leftArm():Plane { return Model.listParts[ 2 ].plane; }
		public function get rightArm():Plane { return Model.listParts[ 3 ].plane; }
		public function get leftLeg():Plane { return Model.listParts[ 4 ].plane; }
		public function get rightLeg():Plane { return Model.listParts[ 5 ].plane; }
		
	}
	
}