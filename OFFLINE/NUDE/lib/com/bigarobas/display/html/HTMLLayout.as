package com.bigarobas.display.html {
	import com.bigarobas.display.layout.Layout;
	import com.bigarobas.display.layout.LayoutMode;
	import com.bigarobas.ui.Label;
	import com.bigarobas.ui.Window;
	import flash.text.StyleSheet;
	import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class HTMLLayout extends Layout implements IHTML{
		private var _css:StyleSheet = null;
		private var _idCss:Object;
		private var _classCss:Object;
		private var _html:XML=null;
		private var _Label:Label;
		private var _window:Window;
		private var _htmlid:String;
		private var _htmlclass:String;
		
		public function HTMLLayout(vHTML:XML=null, vCSS:StyleSheet = null) {
			_html = vHTML;
			_css = vCSS;
			
			layoutOptions.mode = LayoutMode.VERTICAL;	
			
			_window = new Window("HTMLLayout");
			_Label = new Label("HTMLLayout");
			
			if (_html != null) { ;
			
				var tTitle:String = "id : "+_html.@id;
				_window.title = tTitle;
				
				_htmlid = "#" + _html.@id;
				_htmlclass = "." + _html.attribute("class");
				//_htmlclass = ".groupe";
				
				if (_css!=null) {
					_idCss = _css.getStyle(_htmlid);
					_classCss = _css.getStyle(_htmlclass);
					//MonsterDebugger.trace(this, _classCss);
					padding = int(_classCss.padding);
					if (_classCss.arrangeMode) {
						MonsterDebugger.trace(this, _classCss.arrangeMode);
						layoutOptions.mode = _classCss.arrangeMode;
					}
					
				}
			}
			addChild(_window);
			
			
			
		}
		
		public function addHTMLChild(vHTMLLayout:HTMLLayout):void {
			addChild(vHTMLLayout);
		}
		
		public function get css():StyleSheet { return _css; }
		
		public function set css(value:StyleSheet):void {
			_css = value;
			arrange();
		}
		
		public function get html():XML { return _html; }
		
		public function set html(value:XML):void {
			_html = value;
		}
		
	}
	
}