package
{
	import flash.display.BitmapData;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	public class GameObjectManager
	{
		public var backBuffer:BitmapData;
		public var clearColor:uint = 0xff0043AB;
		
		private static var instance:GameObjectManager;
		
		private var lastFrame:Date;
		private var gameObjects:ArrayCollection = new ArrayCollection();
		private var newGameObjects:ArrayCollection = new ArrayCollection();
		private var removedGameObjects:ArrayCollection = new ArrayCollection();
		
		public function GameObjectManager()
		{
			if( instance )
				throw new Error( "This is a Singleton class, only one instance can be instanciated." );
			
			backBuffer = new BitmapData( Application.application.width, Application.application.height, false, clearColor );
		}
		
		public static function getInstance():GameObjectManager
		{
			if( !instance )
				instance = new GameObjectManager();
			
			return instance;
		}
		
		public function startUp():void
		{
			lastFrame = new Date();
		}
		
		public function shutDown():void
		{
			
		}
		
		public function render():void
		{
			var thisFrame:Date = new Date();
			var seconds:Number = (thisFrame.getTime() - lastFrame.getTime() ) * .001;
			lastFrame = thisFrame;
			
			removedDeletedGameObjects();
			insertNewGameObjects();
			
			for each( var gameObject:GameObject in gameObjects )
			{
				if( gameObject.inuse )
					gameObject.render( seconds );
			}
			
			drawObjects();
		}
		
		public function addGameObject( object:GameObject ):void
		{
			newGameObjects.addItem( object );
		}
		
		public function removeGameObject( object:GameObject ):void
		{
			removedGameObjects.addItem( object );
		}
		
		public function shutDownAll():void
		{
			for each( var gameObject:GameObject in gameObjects )
			{
				var found:Boolean;
				for each( var removedObject:GameObject in removedGameObjects )
				{
					if( removedObject == gameObject )
					{
						found = true;
						break;
					}
				}
				if( !found )
					gameObject.shutDown();
			}
		}
		
		private function removedDeletedGameObjects():void
		{
			
		}
		
		private function insertNewGameObjects():void
		{
			
		}
		
		private function drawObjects():void
		{
			backBuffer.fillRect( backBuffer.rect, clearColor );
			
			for each( var gameObject:GameObject in gameObjects )
			{
				if( gameObject.inuse )
				 gameObject.copyToBackBuffer( backbuffer );
			}
		}

	}
}