
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import fl.controls.TextInput;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.utils.UText;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Form extends MovieClip
	{
		// - CONST -----------------------------------------------------------------------
		
		public static const STEP_BACK:String = "step_back";
		public static const END:String = "end";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _px:Number;
		private var _py:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var zValid:MovieClip;
		public var zInvalid:MovieClip;
		public var inputNom:TextInput;
		public var inputPrenom:TextInput;
		public var inputMail:TextInput;
		public var invalidNom:MovieClip;
		public var invalidPrenom:MovieClip;
		public var invalidMail:MovieClip;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Form() 
		{
			_px = 980 * .5 - this.width * .5;
			_py = 560 * .5 - this.height * .5;
			
			this.visible = false;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			invalidNom.visible = invalidPrenom.visible = invalidMail.visible = false;
			
			zValid.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			zValid.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			zValid.addEventListener( MouseEvent.CLICK, onClick );
			
			zInvalid.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			zInvalid.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			zInvalid.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			MovieClip( e.currentTarget ).gotoAndPlay( "over" );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			MovieClip( e.currentTarget ).gotoAndPlay( "out" );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case zValid: validateForm(); break;
				case zInvalid: closeForm(); break;
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function validateForm():void
		{
			invalidNom.visible = invalidPrenom.visible = invalidMail.visible = false;
			
			var errors:int;
			if ( inputNom.text == "" )
			{
				invalidNom.visible = true;
				errors++;
			}
			if ( inputPrenom.text == "" ) 
			{
				invalidPrenom.visible = true;
				errors++;
			}
			if ( inputMail.text == "" || !UText.isMailValid( inputMail.text ) )
			{
				invalidMail.visible = true;
				errors++;
			}
			
			if ( errors ) return;
			dispatchEvent( new Event( Form.END ) );
		}
		
		private function closeForm():void
		{
			dispatchEvent( new Event( Form.STEP_BACK ) );
		}
		
		private function hideForm():void
		{
			this.visible = false;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function display():void
		{
			this.alpha = .4;
			this.x = _px;
			this.y = _py + 50;
			this.visible = true;
			
			TweenLite.to( this, .4, { alpha: 1, y: _py, ease: Quad.easeOut } );
		}
		
		public function hide():void
		{			
			TweenLite.to( this, .3, { alpha: .4, y: _py + 50, ease: Quad.easeOut, onComplete: hideForm } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}