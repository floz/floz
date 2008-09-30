package interfaceSite 
{
	import caurina.transitions.Tweener;
	import five3D.display.Bitmap3D;
	import five3D.display.DynamicText3D;
	import five3D.display.Sprite3D;
	import five3D.typography.MatrixCodeNFI;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import main.Main;
	
	public class Projets extends Sprite3D
	{
		private const size:int = 24;		
		private const positions:Array = [ { x: 50, y: 50 }, { x: 300, y: 50 }, { x: 550, y: 50 }, { x: 50, y: 250 }, { x: 300, y: 250 }, { x: 550, y: 250 } ];
		
		private var main:Main;
		
		private var a:Array;
		private var s:Sprite3D;
		private var b:Bitmap3D;
		private var t:DynamicText3D;
		private var bmpd:BitmapData;
		private var currentIndex:int;
		private var lastIndex:int;
		private var loader:Loader;
		private var request:URLRequest;
		
		private var container:Sprite3D;
		
		public function Projets() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			var n:int = numChildren;
			for ( var i:int; i < n; i++ )
			{
				getChildAt( i ).removeEventListener( MouseEvent.MOUSE_OVER, onOver );
				getChildAt( i ).removeEventListener( MouseEvent.MOUSE_OUT, onOut );
				getChildAt( i ).removeEventListener( MouseEvent.CLICK, onClick );
			}
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			Tweener.removeTweens( this );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			main = getAncestor( this, Main ) as Main;
			
			initialize();
		}
		
		private function onLoadComplete(e:Event):void 
		{			
			bmpd.draw( e.currentTarget.content );			
			b = new Bitmap3D( bmpd );
			
			b.rotationX = Math.random() * 360 - 180;
			b.rotationY = Math.random() * 360 - 180;
			b.rotationZ = Math.random() * 360 - 180;
			s.rotationX = Math.random() * 360 - 180;
			s.rotationY = Math.random() * 360 - 180;
			s.rotationZ = Math.random() * 360 - 180;
			
			container = new Sprite3D();
			container.x = 350;
			container.y = 200;
			container.alpha = 0;
			container.addChild( b );
			container.addChild( s );
			container.buttonMode = true;
			container.extra = { sprite: s, bitmap: b, url: main.projets[ currentIndex ].url };
			container.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			container.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			container.addEventListener( MouseEvent.CLICK, onClick );
			
			addChild( container );
			
			Tweener.addTween( s, { rotationX: Math.random()*10 - 5, rotationY: Math.random()*10 - 5, rotationZ: 0, time: 1, transition: "easeInOutQuad" } );
			Tweener.addTween( b, { rotationX: Math.random()*10 - 5, rotationY: Math.random()*10 - 5, rotationZ: 0, time: 1, transition: "easeInOutQuad" } );
			Tweener.addTween( container, { x: positions[ currentIndex ].x, y: positions[ currentIndex ].y, alpha: 1, time: 1, transition: "easeInOutQuad" } );
			
			loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadComplete );
			loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			loader = null;
			
			if ( currentIndex < lastIndex - 1 )
			{
				currentIndex++;			
				loadNext();	
			}
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "IOErrorEvent.IO_ERROR >", request.url );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			Tweener.addTween( e.currentTarget.extra.sprite, { scaleX: 1.2, scaleY: 1.2, time: .2, transition: "easeInOutQuad" } );
			Tweener.addTween( e.currentTarget.extra.sprite.extra.t, { _color: 0x199181, time: .2, transition: "easeInOutQuad" } );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			Tweener.addTween( e.currentTarget.extra.sprite, { scaleX: 1, scaleY: 1, time: .2, transition: "easeInOutQuad" } );
			Tweener.addTween( e.currentTarget.extra.sprite.extra.t, { _color: 0x0c6c83, time: .2, transition: "easeInOutQuad" } );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			navigateToURL( new URLRequest( e.currentTarget.extra.url ), "_blank" );
		}
		
		// PRIVATE
		
		private function initialize():void
		{
			currentIndex = 0;
			lastIndex = main.projets.length;
			
			a = [];
			
			loadNext();
		}
		
		private function loadNext():void
		{	
			// TITRE
			t = new DynamicText3D( MatrixCodeNFI );
			t.size = size;
			t.color = 0x0c6c83;
			t.text = main.projets[ currentIndex ].name;
			t.y = -5;
			t.x = 5;
			
			var width:int;
			a = main.projets[ currentIndex ].name.split( "" );
			for ( var i:int; i < a.length; i++ )
				width += (MatrixCodeNFI.__widths[ a[ i ] ] * (t.size / 100));
			
			s = new Sprite3D();
			s.graphics3D.beginFill( 0x000000 );
			s.graphics3D.drawRect( 0, 0, width + 20, size );
			s.graphics3D.endFill();
			s.y = -size;
			
			s.addChild( t );
			s.extra = { t: t };
			
			// IMAGES
			bmpd = new BitmapData( 150, 150, true, 0xffffff );
			
			request = new URLRequest( main.path_img + main.projets[ currentIndex ].image );
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			loader.load( request );
		}
		
		private function getAncestor( child:DisplayObject, type:* ):DisplayObject
		{
			var c:DisplayObject = child.parent;
			
			while ( c.parent )
			{
				if ( c.parent is type ) return c.parent;
				c = c.parent;
			}
			
			return null;
		}
		
	}
	
}