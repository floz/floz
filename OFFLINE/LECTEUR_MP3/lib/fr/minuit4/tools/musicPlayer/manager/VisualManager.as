
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.manager 
{
	
	public class VisualManager 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:VisualManager;
		
		private var _backgroundColor:uint = 0xffffff;
		private var _backgroundElementColor:uint = 0x000000;
		private var _linesColor:uint = 0x888888;
		private var _playerWidth:Number = 300;
		private var _deviceHeight:Number = 200;
		private var _playlistHeight:Number = 100;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function VisualManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, use getInstance() methode instead." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():VisualManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new VisualManager();
				} _allowInstanciation = false;
			}
			
			return _instance;
		}
		
		// COLORS
		public function setBackgroundColor( value:uint ):void { this._backgroundColor = value; }
		public function getBackgroundColor():uint {	return this._backgroundColor; }
		
		public function setBackgroundElementColor( value:uint ):void { this._backgroundElementColor = value; }
		public function getBackgroundElementColor():uint { return this._backgroundElementColor; }
		
		public function setLinesColor( value:uint ):void { this._linesColor = value; }
		public function getLinesColor():uint { return this._linesColor; }
		
		// DIMENSIONS
		
		public function setPlayerWidth( value:Number ):void { this._playerWidth = value; }
		public function getPlayerWidth():Number { return this._playerWidth; }
		
		public function setDeviceHeight( value:Number ):void { this._deviceHeight = value; }
		public function getDeviceHeight():Number { return this._deviceHeight; }
		
		public function setPlaylistHeight( value:Number ):void { this._playlistHeight = value; }
		public function getPlaylistHeight():Number { return this._playlistHeight; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}