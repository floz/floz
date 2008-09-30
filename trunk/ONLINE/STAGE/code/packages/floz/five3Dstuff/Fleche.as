package floz.five3Dstuff 
{
	import five3D.display.Sprite3D;
	
	public class Fleche extends Sprite3D
	{
		private var color:uint;
		private var size:Number;
		private var alpha:Number;
		
		public function Fleche( color:uint, size:Number, alpha:Number ) 
		{
			this.color = color;
			this.size = size;
			
			create();
		}
		
		private function create():void
		{
			this.graphics3D.beginFill( color, alpha );
			this.graphics3D.moveTo( -size/2, -size/2 );
			this.graphics3D.lineTo( size / 2, 0 );
			this.graphics3D.lineTo( -size/2, size/2 );
			this.graphics3D.endFill();
		}
		
	}
	
}