
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
		
		/**
		 * Méthode de traitement des touches pressées par l'utilisateur.
		 * @param	e
		 */
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			var idx:int = _keys.indexOf( e.keyCode, 0 );
			if ( idx > -1 )
			{
				// On vérifie que la touche n'est pas celle qui est actuellement utilisée.
				if ( idx == int( _keys.length - 1 ) )
					return;
				
				// Si la touche est déjà enregistrée, on la passe devant les autres.
				_keys.push( _keys.splice( idx, 1 )[ 0 ] );
			}
			
			onKey( e.keyCode );
			_keys.push( e.keyCode );
			
			play();
		}
		
		/**
		 * Actions effectuées lorsque l'utilisateur lache une touche.
		 * @param	e
		 */
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
				// On supprime la touche qui vient d'être relachée.
				_keys.splice( idx, 1 );
				
				var l:int = _keys.length;
				if ( l > 0 ) 
				{
					// Si une touche est encore appuyée, on la passe en priorité.
					onKey( _keys[ int( l - 1 ) ] );
				}
				else 
				{
					// Si plus aucune touche n'est appuyée, on stoppe le personnage.
					stop();
				}
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_keys = new Vector.<uint>();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		/**
		 * Déclenche les actions liées à une touche de clavier.
		 * @param	key	uint	Le code de la touche de clavier.
		 */
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