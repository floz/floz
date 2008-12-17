
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class GuestsList extends MovieClip
	{
		public static const CLICK:String = "click";
		
		public var cnt:MovieClip;
		
		private var document:Table;
		
		private var list:Array;
		private var pos:Array;
		
		private var currentGuest:Guest;
		
		private var scrollValue:int;
		private var idxMax:int;
		
		public function GuestsList() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			Tweener.removeTweens( this );
			
			var g:Guest;
			var n:int = cnt.numChildren;
			for ( var i:int; i < n; i++ )
			{
				if ( i )
				{
					g = cnt.getChildAt( i ) as Guest;
					g.removeEventListener( MouseEvent.CLICK, onClick );
				}
			}
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			document = getAncestor( this, Table ) as Table;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			currentGuest = Guest( e.currentTarget );
			dispatchEvent( new Event( Event.ACTIVATE ) );
		}
		
		// PRIVATE
		
		private function affiche():void
		{			
			Tweener.removeTweens( this );
			Tweener.addTween( this, { x: pos[ scrollValue ], time: .5, transition: "linear" } );
		}
		
		private function getAncestor( child:DisplayObject, type:* ):*
		{
			var d:DisplayObject = child;
			
			while ( d.parent )
			{
				if ( d.parent is type ) return d.parent;
				d = d.parent;
			}
			
			return null;
		}
		
		// PUBLIC
		
		public function init():void
		{
			list = [];
			
			var g:Guest;
			
			var i:int;
			var n:int = 5;
			for ( i; i < n; i++ )
			{
				g = i ? new Guest() : new Guest( document.getPortrait() );
				g.x = g.width * i + i * 50;
				cnt.addChild( g );
				
				if ( i )
				{
					g.addEventListener( MouseEvent.CLICK, onClick );
					g.buttonMode = true;
				}
			}
			
			idxMax = 2;
			
			pos = [ 50, 50 - ( 50 + 261 ), 50 - ( 50 * 2 + 261 * 2 ), 50 - ( 50 * 3 + 261 * 3 ) ];
		}
		
		public function toRight():Boolean
		{
			if ( scrollValue + 1 <= idxMax ) 
			{
				scrollValue++;				
				affiche();
				
				return true;
			}
			
			return false;
		}
		
		public function toLeft():Boolean
		{
			if ( scrollValue - 1 >= 0 ) 
			{
				scrollValue--;			
				affiche();
				
				return true;
			}
			return false;
		}
		
		public function select( m:MovieClip ):void
		{
			currentGuest.choose( m );
		}
		
		// GETTERS & SETTERS
		
		public function getIdxMax():int
		{
			return this.idxMax;
		}
		
		public function getScrollValue():int
		{
			return this.scrollValue;
		}
		
		public function getSelectedIdx():int { return cnt.getChildIndex( currentGuest ); }
		
	}
	
}