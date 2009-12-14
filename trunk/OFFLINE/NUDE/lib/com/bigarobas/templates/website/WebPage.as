package com.bigarobas.templates.website {
	import com.bigarobas.display.layout.Layout;
	import com.bigarobas.display.layout.LayoutMode;
	import com.bigarobas.templates.Main;
	import com.bigarobas.utils.language.ICosmopolite;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class WebPage extends Layout implements IWebPage,ICosmopolite{
		
		protected var _pages:WebPageManager;
		protected var _address:String;
		
		public function WebPage() {
			_pages = new WebPageManager();
		}
		
		/* INTERFACE com.bigarobas.utils.language.ICosmopolite */
		
		public function translate():void{
			
		}
		
		public function registerToLanguageManager():void{
			Main.languageManager.add(this);
		}
		
		
		/* INTERFACE com.bigarobas.templates.website.IWebPage */
		
		public function get address():String { return _address; }
		
		public function set address(value:String):void {
			_address = value;
		}
		
		public function addPage(vPage:IWebPage):IWebPage {
			addChild(vPage as DisplayObject);
			_pages.add(vPage);
			return(vPage);
		}
		
		public function removePage(vPage:IWebPage):IWebPage {
			if (_pages.has(vPage)) {
				addChild(vPage as DisplayObject);
				_pages.add(vPage);
			}
			return(vPage);
		}
		
		public function close():void{
			
		}
		
		public function open():void{
			
		}
		
		
		
	}
	
}