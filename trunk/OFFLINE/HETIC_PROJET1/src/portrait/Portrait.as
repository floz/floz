
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Portrait extends MovieClip 
	{
		public var sketch:Sketch;
		public var menuCtrl:MenuCtrl;
		public var bibliotheque:Bibliotheque;
		public var confirmation:Confirmation;
		public var zErase:SimpleButton;
		public var zEraseAll:SimpleButton;
		public var zValid:SimpleButton;
		
		private var datas:Datas;
		
		public function Portrait() 
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
			
			datas = new Datas( "xml/portrait.xml" );
			datas.addEventListener( Event.COMPLETE, onDatasComplete );
			datas.load();
		}
		
		private function onDatasComplete(e:Event):void 
		{
			
			
			zValid.addEventListener( MouseEvent.CLICK, onClick );
			zEraseAll.addEventListener( MouseEvent.CLICK, onClick );
			confirmation.addEventListener( Confirmation.YES, onRespond );
			confirmation.addEventListener( Confirmation.NO, onRespond );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case zValid : confirmation.show( Confirmation.VALIDATION ); break;
				case zEraseAll : confirmation.show( Confirmation.SUPPRESSION ); break;
			}
		}
		
		private function onRespond(e:Event):void 
		{
			if ( e.type == Confirmation.YES )
			{
				switch( confirmation.state )
				{
					case Confirmation.VALIDATION : trace( "validation du portrait" ); break;
					case Confirmation.SUPPRESSION : sketch.clean(); break;
				}
			}
			
			confirmation.hide();
		}
		
		// PRIVATE	
		
		// PUBLIC
		
	}
	
}