package interfaceSite 
{
	import caurina.transitions.Tweener;
	import five3D.display.DynamicText3D;	
	import five3D.display.Sprite3D;
	import five3D.typography.MatrixCodeNFI;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import floz.utils.UDis;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import main.Main;
	
	public class Menu extends Sprite3D
	{
		static public const CLICK:String = "click";
		static public const SELECT:String = "select";
		
		private const size:int = 24;
		
		private var bgColor:uint;
		
		private var background :Sprite3D;
		private var lines:Sprite3D;
		private var main:Main;
		
		public var selected:String;
		
		public function Menu( bgColor:uint ) 
		{
			this.bgColor = bgColor;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			Tweener.removeTweens( this );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage )
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			for ( var i:int; i < numChildren; i++ )
			{
				getChildAt( i ).removeEventListener( MouseEvent.CLICK, onClick );
				getChildAt( i ).removeEventListener( MouseEvent.ROLL_OVER, onOver );
				getChildAt( i ).removeEventListener( MouseEvent.ROLL_OUT, onOut );
			}
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			main = getAncestor( this, Main ) as Main;
			
			create();
		}
		
		private function onClick(e:MouseEvent):void 	// PAS TIP TOP CODE FLO, CAY PAS TRES TRES BIEN
		{			
			if ( e != null ) 
			{
				if ( selected == e.currentTarget.name ) return;
				selected = e.currentTarget.name;
				deselect();
			} else 
			{
				if ( selected ) return;
				selected = main.rubriques[ 0 ];
			}
				var s:DisplayObject;
				s = getChildByName( selected ) as DisplayObject;
				setChildIndex( s, numChildren-1 );
				
				var s3D:Sprite3D = s as Sprite3D;
				Tweener.addTween( s, { scaleX: 1.2, scaleY: 1.2, time: .15, transition: "easeInOutQuad" } );
				Tweener.addTween( s3D.extra.t, { _color: 0x59b26d, time: .15, transition: "easeInOutQuad" } );
				
				dispatchEvent( new Event( Menu.SELECT ) );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if ( selected == e.currentTarget.name ) return;
			
			var s:DisplayObject = e.currentTarget as DisplayObject;
			setChildIndex( s, numChildren-2 );
			
			Tweener.addTween( e.currentTarget, { scaleX: 1.2, scaleY: 1.2, time: .15, transition: "easeInOutQuad" } );
			Tweener.addTween( e.currentTarget.extra.t, { _color: 0x199181, time: .15, transition: "easeInOutQuad" } );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if ( selected == e.currentTarget.name ) return;
			
			Tweener.addTween( e.currentTarget, { scaleX: 1, scaleY: 1, time: .15, transition: "easeInOutQuad" } );
			Tweener.addTween( e.currentTarget.extra.t, { _color: 0x0c6c83, time: .15, transition: "easeInOutQuad" } );
		}
		
		// PRIVATE
		
		private function create():void
		{
			var a:Array = [];
			var s:Sprite3D;
			var t:DynamicText3D;
			var width:Number = 0;
			var height:Number = 0;
			var i:int;
			var n:int;
			for each ( var item:String in main.rubriques )
			{				
				t = new DynamicText3D( MatrixCodeNFI );
				t.size = size;
				t.text = item;
				t.color = 0x0c6c83;
				t.y = -5;
				t.x = 5;
				
				a = item.split( "" );
				n = a.length;
				for ( i; i < n; i++ )
					width += (MatrixCodeNFI.__widths[ a[ i ] ] * (t.size / 100));
				
				height = t.size;
				
				s = new Sprite3D();
				s.graphics3D.beginFill( bgColor );
				s.graphics3D.drawRect( 0, 0, width + 10, height );
				s.graphics3D.endFill();
				
				s.addChild( t );
				s.extra = { t: t };
				s.y = -100;
				s.z = -200;
				s.rotationX = 180*5;
				s.name = item;				
				s.buttonMode = true;
				s.addEventListener( MouseEvent.CLICK, onClick );
				s.addEventListener( MouseEvent.ROLL_OVER, onOver );
				s.addEventListener( MouseEvent.ROLL_OUT, onOut );
				addChild( s );
				
				width = 0;
				i = 0;
				n = 0;
			}
			
			a = null;
			s = null;
			t = null;
			
			show();
		}
		
		private function show():void
		{
			var childs:Array = UDis.getChildren( this );
			
			var i:int;
			var n:int = numChildren;
			for ( i; i < n; i++ )
			{
				if ( i != (n - 1) ) Tweener.addTween( childs[ i ], { z: 0, x: 20, y: i * size + i * .5, rotationX: 0, rotationY: Math.random() * 10 - 5, rotationZ: Math.random() * 1 - .5, time: .5, delay: i * .3, transition: "easeInOutQuad" } );
					else Tweener.addTween( childs[ i ], { z: 0, x: 20, y: i * size + i*.5, rotationX: 0, rotationY: Math.random() * 10 - 5, rotationZ: Math.random() * 1 - .5, time: .5, delay: i * .3, transition: "easeInOutQuad", onComplete: onClick, onCompleteParams: [ null ] } );
			}			
			
		}
		
		private function deselect():void
		{
			var childs:Array = UDis.getChildren( this );
			
			var s:Sprite3D;
			var i:int;
			var n:int = numChildren;
			for ( i; i < n; i++ )
			{
				s = getChildAt( i ) as Sprite3D;
				if ( s.name != selected ) 
				{
					Tweener.addTween( s, { scaleX: 1, scaleY: 1, time: .15, transition: "easeInOutQuad" } );
					Tweener.addTween( s.extra.t, { _color: 0x0c6c83, time: .15, transition: "easeInOutQuad" } );
				}
			}
		}
		
		private function getAncestor( child:DisplayObject, type:* ):DisplayObject
		{
			var c:DisplayObject = child;
			
			while ( c.parent )
			{
				if ( c.parent is type ) return c.parent;
				c = c.parent;
			}
			
			return null;
		}
		
		// PUBLIC
		
	}
	
}