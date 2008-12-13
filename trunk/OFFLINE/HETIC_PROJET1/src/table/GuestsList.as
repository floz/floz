
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
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
		
		public function GuestsList() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			document = getAncestor( this, Table ) as Table;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			dispatchEvent( new Event( GuestsList.CLICK ) );
		}
		
		// PRIVATE
		
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
				g = new Guest();
				g.x = g.width * i + i * 50;
				cnt.addChild( g );
				
				g.addEventListener( MouseEvent.CLICK, onClick );
			}
		}
		
	}
	
}