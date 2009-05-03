
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class ConnectWindow extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _pseudo:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var bt:SimpleButton;
		public var pseudo:TextField;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ConnectWindow() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			pseudo.text = "";
			
			addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );			
			bt.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if ( e.charCode == 13 && pseudo.text != "" )
			{
				onClick( null );
				removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if ( pseudo.text == "" ) return;
			
			bt.removeEventListener( MouseEvent.CLICK, onClick );
			
			_pseudo = pseudo.text;			
			pseudo.type = TextFieldType.DYNAMIC;
			pseudo.selectable = false;
			
			dispatchEvent( new Event( Event.CONNECT ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function destroy():void
		{
			parent.removeChild( this );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function hide():void
		{
			TweenLite.to( this, .5, { alpha: 0, ease: Quad.easeOut, onComplete: destroy } );
		}
		
		public function getPseudo():String
		{
			return this._pseudo;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}