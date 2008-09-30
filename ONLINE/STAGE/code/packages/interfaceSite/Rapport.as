package interfaceSite 
{
	import caurina.transitions.Tweener;
	import five3D.display.DynamicText3D;
	import five3D.display.Sprite3D;
	import five3D.typography.MatrixCodeNFI;
	import flash.display.DisplayObject;
	import flash.filters.DropShadowFilter;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import floz.utils.UDis;
	import main.Main;
	
	public class Rapport extends Sprite3D
	{
		private var main:Main;
		
		public function Rapport()
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS		
		private function onRemovedFromStage(e:Event):void 
		{
			var a:Array = UDis.getChildren( this );
			var n:int = a.length;
			for ( var i:int; i < n; i++ )
			{
				a[i].removeEventListener( MouseEvent.ROLL_OVER, onOver );
				a[i].removeEventListener( MouseEvent.CLICK, onClick );
				
			}
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			Tweener.removeTweens( this );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			main = getAncestor( this, Main ) as Main;
			
			create();
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if ( e.currentTarget.extra.axe )
			{
				e.currentTarget.extra.axe = !e.currentTarget.extra.axe;
				Tweener.addTween( e.currentTarget, { z: -200, time: 1, transition: "easeInOutQuad", onComplete: comeBack, onCompleteParams: [ e.currentTarget ] } );
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{
			navigateToURL( new URLRequest( main.path_pdf + "rapport.pdf" ), "_blank" );
		}
		
		// PRIVATE
		private function create():void
		{		
			var txt:String = "CLIQUEZ ICI POUR TELECHARGER LE RAPPORT";
			var tabString:Array = txt.split( "" );
			
			var t:DynamicText3D;
			var s:Sprite3D;
			var letterPosition:Number = 0;
			var letterWidth:Number = 0;
			
			var i:int;
			var n:int = tabString.length;
			for ( i; i < n; i++ )
			{
				t = new DynamicText3D( MatrixCodeNFI );
				t.size = 30;
				t.color = 0x000000;
				t.text = tabString[ i ]
				
				s = new Sprite3D();
				s.graphics3D.beginFill( 0x000000, 0 );
				s.graphics3D.drawRect( 0, 0, letterWidth, MatrixCodeNFI.__heights * (t.size / 100) );
				s.graphics3D.endFill();
				s.x = letterPosition;
				
				letterWidth = MatrixCodeNFI.__widths[ tabString[ i ] ] * ( t.size / 100 );
				letterPosition += letterWidth;
				
				s.addChild( t );
				
				addChild( s );
				
				s.extra = { axe: true };
				
				s.addEventListener( MouseEvent.ROLL_OVER, onOver );
				s.addEventListener( MouseEvent.CLICK, onClick );
			}
			var txtWidth:Number = letterPosition;
			var txtHeight:Number = MatrixCodeNFI.__widths[ "C" ] * ( t.size / 100 );
			
			this.x = -txtWidth / 2 + 350;
			this.y = -txtHeight + 150;
			
			//var filters:Array = [ new DropShadowFilter( 0, 45, 0x000000, 1, 3, 3, 2, 3 ) ];
			//this.filters = filters;
		}
		
		private function comeBack( s:Sprite3D ):void
		{
			Tweener.addTween( s, { z: 0, time: 1, transition: "easeInOutQuad", onComplete: function():void { s.extra.axe = !s.extra.axe } } );
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