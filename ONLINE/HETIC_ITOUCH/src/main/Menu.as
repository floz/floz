
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Menu extends MovieClip
	{
		public static const SELECTED:String = "selected";
		
		public var zIndex:SimpleButton;
		public var zApplications:SimpleButton;
		public var zCaracteristiques:SimpleButton;
		public var zVideo:SimpleButton;
		public var zSon:SimpleButton;
		
		private var _event:Event;
		
		private var _rubriqueName:String;
		private var _zActivated:SimpleButton
		private var _saveState:DisplayObject;
		
		public function Menu() 
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
			
			_event = new Event( Menu.SELECTED );
			
			zIndex.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			zApplications.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			zCaracteristiques.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			zVideo.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			zSon.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
		}
		
		private function onDown(e:MouseEvent):void 
		{
			if ( !enabled ) return;
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
		}
		
		private function onUp(e:MouseEvent):void 
		{			
			if ( !enabled ) return;
			stage.removeEventListener( MouseEvent.MOUSE_UP, onUp );
			
			switch( e.target )
			{
				case zIndex : 
					_rubriqueName = "Index"; 
					
					if ( _saveState ) _zActivated.upState = _saveState;
					break;
				case zApplications : 
					_rubriqueName = "Applications";
					
					state( zApplications );
					break;
				case zCaracteristiques : 
					_rubriqueName = "Caractéristiques"; 
					
					state( zCaracteristiques );
					break;
				case zVideo : 
					_rubriqueName = "Vidéo";
					
					state( zVideo );
					break;
				case zSon : 
					_rubriqueName = "Son";
					
					state( zSon );
					break;
			}
			
			dispatchEvent( _event );
		}
		
		// PRIVATE
		
		private function state( z:SimpleButton ):void
		{
			if ( _saveState ) _zActivated.upState = _saveState;
			
			_zActivated = z;
			_saveState = z.upState;
			z.upState = z.overState;
		}
		
		public function get rubriqueName():String { return _rubriqueName; }
		
		public function set rubriqueName(value:String):void 
		{
			_rubriqueName = value;
			
			switch( value )
			{
				case "Index" :					
					if ( _saveState ) _zActivated.upState = _saveState;
					break;
				case "Applications" : 					
					state( zApplications );
					break;
				case "Caractéristiques" : 					
					state( zCaracteristiques );
					break;
				case "Vidéo" : 					
					state( zVideo );
					break;
				case "Son" : 					
					state( zSon );
					break;
			}
		}
		
		// PUBLIC
		
	}
	
}