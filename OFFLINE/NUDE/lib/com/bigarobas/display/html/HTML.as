package com.bigarobas.display.html {
	import flash.text.StyleSheet;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class HTML {
		
		static public function renderHTMLLayout(vXML:XML,vCSS:StyleSheet=null):HTMLLayout {
			//var xml:XML = HTMLStringToXML(vXMLString);
			var htmlLayout:HTMLLayout = new HTMLLayout(null,vCSS);
			fillHTMLLayoutWithXML(htmlLayout, vXML,vCSS);
			return (htmlLayout);
		}
		
		static private function fillHTMLLayoutWithXML(vHTMLLayout:HTMLLayout,vXML:XML,vCSS:StyleSheet=null):HTMLLayout{
			var nchild:int = vXML.children().length();
			var childXML:XML;
			for (var i:int = 0; i < nchild; i++) {
				childXML = XML(vXML.children()[i]);
				var tTitle:String = childXML.name() + " | " + childXML.@id + " | " + i.toString();
				var childLayout:HTMLLayout = new HTMLLayout(childXML,vCSS);
				fillHTMLLayoutWithXML(childLayout, childXML,vCSS);
				vHTMLLayout.addHTMLChild(childLayout);
			}
			return (vHTMLLayout);
		}
		
		static private function HTMLStringToXML(vHMLTString:String):XML{
			return XML(vHMLTString);
		}
		
		
	}
	
}