package five3D.custom 
{
	import five3D.display.Sprite3D;
	import five3D.custom.cube.CubeFace;
	import flash.display.DisplayObject;
	
	public class Cube extends Sprite3D
	{
		private var size:Number;
		private var color:uint;
		private var light:Boolean;
		
		/** Axe des z en positif */
		public var front:CubeFace;
		/** Axe des z en négatif */
		public var back:CubeFace;
		/** Axe des y en négatif */
		public var bottom:CubeFace;
		/** Axe des y en positif */
		public var top:CubeFace;
		/** Axe des x en négatif */
		public var left:CubeFace;
		/** Axe des x en positif */
		public var right:CubeFace;
		
		private var _extra:Object;
		
		public function Cube( size:Number, color:uint, light:Boolean ) 
		{
			//super();
			
			this.size = size;
			this.color = color;
			this.light = light;
			
			buildCube();
		}
		
		// PRIVATE
		private function buildCube():void
		{
			front = new CubeFace( size, color, light, 0, 0, size / 2, 180, 0, 0 );
			addChild( front );
			back = new CubeFace( size, color, light, 0, 0, -size / 2, 0, 0, 0 );
			addChild( back );
			top = new CubeFace( size, color, light, 0, size / 2, 0, 90, 0, 0 );
			addChild( top );
			bottom = new CubeFace( size, color, light, 0, -size / 2, 0, -90, 0, 0 );
			addChild( bottom );
			right = new CubeFace( size, color, light, size / 2, 0, 0, 0, -90, 0 );
			addChild( right );
			left = new CubeFace( size, color, light, -size / 2, 0, 0, 0, 90, 0 );
			addChild( left );
		}
		
		// PUBLIC
		
		// GETTERS & SETTERS
		override public function get extra():Object { return _extra; }
		
		override public function set extra( value:Object ):void 
		{
			extra = value;
		}
		
		public function get faces():Array
		{
			var a:Array = [];
			var c:DisplayObject;
			
			var i:int = 0;
			var n:int = this.numChildren;			
			for ( i; i < n; i++ )
			{
				c = this.getChildAt( i );
				if ( c is CubeFace ) a.push( c );
			}
			
			return a;
		}
		
	}
	
}