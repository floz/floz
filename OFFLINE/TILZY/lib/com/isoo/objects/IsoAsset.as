package com.isoo.objects 
{
	import com.isoo.map.Tile;
	import flash.display.DisplayObject;
	/**
	 * 
	 * @author David Ronai
	 */
	public class IsoAsset extends IsoObject
	{
		
		private var _asset:DisplayObject;
		private var _offsetX:int;
		private var _offsetY:int;
		
		/**
		 * Create an isoObject with displayObject
		 * 
		 * @param	asset
		 * @param	offsetX offset on x abscisse
		 * @param	offsetY offset on y abscisse
		 */
		public function IsoAsset(asset:DisplayObject, offsetX:int = 0, offsetY:int = 0) 
		{
			_asset = asset;
			_offsetX = offsetX;
			_offsetY = offsetY;
			
			_asset.x = _offsetX;
			_asset.y = _offsetY;
			
			addChild( _asset );
			
			mouseChildren = false;
		}
		
		public function get asset():DisplayObject { return _asset; }
		public function set asset(value:DisplayObject):void 
		{
			if ( _asset != null ){
				//removeChild( _asset )
				_asset = null;
			}
			_asset = value;
		}
		
		// - GETTERS AND SETTERS
		
		public function get offsetX():int { return _offsetX; }		
		public function set offsetX(value:int):void 
		{
			_offsetX = value;
			asset.x = _offsetX;
		}
		
		public function get offsetY():int { return _offsetY; }		
		public function set offsetY(value:int):void 
		{
			_offsetY = value;
			asset.y = _offsetY;
		}
		
	}

}