package five3D.custom.cube
{
	import five3D.display.Sprite3D;
	
	public class CubeFace extends Sprite3D
	{
		public var size:Number;
		public var color:uint;
		
		private var anchor:Boolean;
		
		public function CubeFace( size:Number, color:uint, light:Boolean, x:Number, y:Number, z:Number, rotationx:Number, rotationy:Number, rotationz:Number ) 
		{
			this.size = size;
			this.color = color;
			this.x = x;
			this.y = y;
			this.z = z;
			this.rotationX = rotationx;
			this.rotationY = rotationy;
			this.rotationZ = rotationz;
			
			this.singleSided = true;
			this.flatShaded = light;
			
			create();
		}
		
		// PRIVATE		
		private function create():void
		{
			this.graphics3D.beginFill( color );
			this.graphics3D.drawRect( -size/2, -size/2, size, size );
			this.graphics3D.endFill();
		}
		
		public function get anchor():Boolean { return anchor; }
		
		public function set anchor(value:Boolean):void 
		{
			_anchor = value;
		}
		
		// PUBLIC
		
		// GETTERS & SETTERS
	}
	
}