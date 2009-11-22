
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.wtf.mobiles.players 
{
	import com.wtf.misc.AnimationsEnum;
	import com.wtf.misc.KeysEnum;
	import com.wtf.mobiles.Mobile;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class PlayerMobile extends Mobile
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _keys:Vector.<uint>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PlayerMobile() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler, false, 0, true );
			stage.addEventListener( KeyboardEvent.KEY_UP, keyUpHandler, false, 0, true );
		}
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			var idx:int = _keys.indexOf( e.keyCode, 0 );
			if ( idx > -1 )
			{
				if ( idx == int( _keys.length - 1 ) )
					return;
				
				_keys.push( _keys.splice( idx, 1 )[ 0 ] );
			}
			
			onKey( e.keyCode );
			_keys.push( e.keyCode );
			
			play();
		}
		
		private function keyUpHandler(e:KeyboardEvent):void 
		{
			switch( e.keyCode )
			{
				case KeysEnum.LEFT: _vx = 0; break;
				case KeysEnum.TOP: _vy = 0; break;
				case KeysEnum.RIGHT: _vx = 0; break;
				case KeysEnum.BOTTOM: _vy = 0; break;
			}
			
			var idx:int = _keys.indexOf( e.keyCode, 0 );
			if ( idx > - 1 )
			{
				_keys.splice( idx, 1 );
				var l:int = _keys.length;
				if ( l > 0 ) onKey( _keys[ int( l - 1 ) ] );
				else stop();
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_keys = new Vector.<uint>();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function onKey( key:uint ):void
		{
			switch( key )
			{
				case KeysEnum.LEFT: _vx = -1; play( AnimationsEnum.LEFT ); break;
				case KeysEnum.TOP: _vy = -1; play( AnimationsEnum.TOP ); break;
				case KeysEnum.RIGHT: _vx = 1; play( AnimationsEnum.RIGHT ); break;
				case KeysEnum.BOTTOM: _vy = 1; play( AnimationsEnum.BOTTOM ); break;
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}