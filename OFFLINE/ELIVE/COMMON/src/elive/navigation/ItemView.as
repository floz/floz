
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.navigation 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.net.loaders.types.AssetsLoader;
	
	public class ItemView extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _assetsLoader:AssetsLoader;
		
		private var _itemModel:ItemModel;		
		private var _icon:MovieClip;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ItemView() 
		{
			//
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function loadIconCompleteHandler(e:Event):void 
		{
			_icon = _assetsLoader.getItemLoaded() as MovieClip;
			_assetsLoader.removeEventListener( Event.COMPLETE, loadIconCompleteHandler );
			_assetsLoader.dispose();
			
			addChild( _icon );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function config( itemModel:ItemModel ):void
		{
			this._itemModel = itemModel;
		}
		
		public function loadIcon():void
		{
			_assetsLoader = new AssetsLoader( url );
			_assetsLoader.addEventListener( Event.COMPLETE, loadIconCompleteHandler, false, 0, true );
			_assetsLoader.load();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}