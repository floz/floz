
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
	import flash.text.TextField;
	
	public class SexeItem extends MovieClip
	{
		public static const CLICK:String = "click";
		
		public var texte:TextField;
		public var z:SimpleButton;
		
		private var _sexe:String;
		
		public function SexeItem() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			z.removeEventListener( MouseEvent.CLICK, onClick );
			z.removeEventListener( MouseEvent.ROLL_OVER, onOver );
			z.removeEventListener( MouseEvent.ROLL_OUT, onOut );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			z.addEventListener( MouseEvent.CLICK, onClick );
			z.addEventListener( MouseEvent.ROLL_OVER, onOver );
			z.addEventListener( MouseEvent.ROLL_OUT, onOut );
		}
		
		private function onClick(e:Event):void 
		{
			dispatchEvent( new MouseEvent( SexeItem.CLICK ) );
		}
		
		private function onOver(e:Event):void 
		{
			
		}
		
		private function onOut(e:Event):void 
		{
			
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function init( sexe:String )
		{
			texte.text = sexe.toUpperCase();
			
			_sexe = sexe;
		}
		
		public function select():void
		{
			this.alpha = .5;
		}
		
		public function deselect():void
		{
			this.alpha = 1;
		}
		
		// GETTES & SETTERS
		
		public function get sexe():String { return _sexe; }
		
	}
	
}