package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class GameObject
	{
		public var position:Point = new Point();
		public var zOrder:int;
		
		public var graphics:BitmapData;
		
		public var inuse:Boolean;
		
		public function GameObject()
		{
			
		}
		
		public function startUpGameObject( graphics:BitmapData, position:Point, z:int = 0 ):void
		{
			if( !inuse )
			{
				this.graphics = graphics;
				this.zOrder = z;
				this.position = position.clone();
				this.inuse = true;
				
				GameObjectManager.getInstance().addGameObject( this );
			}
		}
		
		public function shutDown():void
		{
			if( inuse )
			{
				this.graphics = null;
				this.inuse = false;
				
				GameObjectManager.getInstance().removeGameObject( this );
			}
		}
		
		public function copyToBackBuffer( bd:BitmapData ):void
		{
			bd.copyPixels( graphics.bitmap, graphics.bitmap.rect, position, graphics.bitmapAlpha, new Point(), true );
		}
		
		public function render( seconds:Number ):void
		{
			
		}

	}
}