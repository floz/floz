
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import accueil.Accueil;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import main.Main;
	
	public class Table extends MovieClip 
	{
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		
		public var zLeft:SimpleButton;
		public var zRight:SimpleButton;
		public var front:MovieClip;
		public var zValid:SimpleButton;
		public var confirmation:Confirmation;
		public var cnt:MovieClip;
		public var gcMenu:GuestsChoiceMenu;
		public var guestsList:GuestsList;
		
		private var document:Main;		
		private var datas:Datas;
		
		public function Table() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			datas.removeEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			document = getAncestor( this, Main ) as Main;
			
			datas = new Datas( "xml/invites.xml" );
			datas.addEventListener( Event.COMPLETE, onLoadComplete );
			datas.load();
		}
		
		private function onLoadComplete(e:Event):void 
		{
			zValid.addEventListener( MouseEvent.CLICK, onClick );
			confirmation.addEventListener( Confirmation.YES, onRespond );
			confirmation.addEventListener( Confirmation.NO, onRespond );
			
			zLeft.addEventListener( MouseEvent.CLICK, onClick );
			zRight.addEventListener( MouseEvent.CLICK, onClick );
			
			guestsList.init();
			guestsList.addEventListener( GuestsList.CLICK, onGuestClick, true );
		}
		
		private function onClick(e:MouseEvent):void 
		{			
			switch ( e.currentTarget )
			{
				case zValid: confirmation.show(); break;
				case zLeft: moveTo( Table.LEFT ); break;
				case zRight: moveTo( Table.RIGHT ); break;
			}	
		}
		
		private function onGuestClick(e:Event):void 
		{
			trace( "Table.onGuestClick" );
			gcMenu.show();
		}
		
		private function onRespond(e:Event):void 
		{
			if ( e.type == Confirmation.YES ) trace ( Confirmation.YES );
			
			confirmation.hide();
		}
		
		// PRIVATE	
		
		private function moveTo( sens:String ):void
		{
			if ( sens == Table.LEFT )
			{
				trace ( Table.LEFT );
			}
			else
			{
				trace ( Table.RIGHT );
			}
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
		
		public function getInfos():Array
		{
			return datas.getInfos();
		}
		
	}
	
}