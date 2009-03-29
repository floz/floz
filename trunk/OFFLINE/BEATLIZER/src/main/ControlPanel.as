
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class ControlPanel extends MovieClip
	{
		// - CONST -----------------------------------------------------------------------
		
		public static const UPLOAD:String = "upload";
		public static const VALID_BEATLES:String = "valid_beatles";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _px:Number;
		private var _py:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var zSearch:MovieClip;
		public var zValid:MovieClip;
		public var bg:MovieClip;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ControlPanel() 
		{
			_px = this.x;
			_py = this.y;
			
			zValid.visible = false;
			
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
			
			this.x = 980 * .5 - this.width * .5 - 10;
			this.y = 560 * .5 - this.height * .5;
			
			zSearch.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			zSearch.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			zSearch.addEventListener( MouseEvent.CLICK, onClick );
			
			zValid.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			zValid.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			zValid.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if ( !Model.enable ) return;
			MovieClip( e.currentTarget ).gotoAndPlay( "over" );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if ( !Model.enable ) return;
			MovieClip( e.currentTarget ).gotoAndPlay( "out" );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if ( !Model.enable ) return;
			switch( e.currentTarget )
			{
				case zSearch: uploadPhoto(); break;
				case zValid: fillForm(); break;
			}
			zSearch.gotoAndPlay( "out" );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function uploadPhoto():void
		{
			dispatchEvent( new Event( ControlPanel.UPLOAD ) );
		}
		
		private function showValidButton():void
		{
			zValid.scaleX = zValid.scaleY = 0;
			zValid.visible = true;
			TweenLite.to( zValid, .2, { scaleX: 1, scaleY: 1, ease: Quad.easeOut } );
		}
		
		private function fillForm():void
		{
			dispatchEvent( new Event( ControlPanel.VALID_BEATLES ) );			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function init():void
		{
			TweenLite.to( this, .2, { x: _px, y: _py, ease: Quad.easeOut } );
			TweenLite.to( bg, .2, { height: 145, ease: Quad.easeOut, delay: .2, onComplete: showValidButton } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}