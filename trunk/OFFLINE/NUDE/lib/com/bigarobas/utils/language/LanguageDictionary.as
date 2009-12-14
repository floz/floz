package com.bigarobas.utils.language {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class LanguageDictionary {
		protected var _language:String;
		protected var _words:Array;
		protected var _undefinedWord:String="undefined";
		public function LanguageDictionary(vLanguage:String = "",vXML:XML=null,vUndefinedWord:String=null) {
			_language=vLanguage
			_words = [];
			if (vXML != null) setXML(vXML);
			if (vUndefinedWord != null) _undefinedWord = vUndefinedWord;
		}
		
		private function setXML(vXML:XML):void{
			_words = [];
			if (vXML.@undefinedword) _undefinedWord = vXML.@undefinedword;
			for each (var ref:XML in vXML.children()) {
				setWord(ref.@id, ref.toString());
			}
		}	
		
		public function get language():String { return _language; }
		
		public function set language(value:String):void {
			_language = value;
		}
		
		public function setWord(vID:String, vWord:String):void {
			_words[vID] = vWord;
		}
		
		public function getWord(vID:String):String {
			var word:String;
			if (_words[vID] != null) {
				word = _words[vID];
			} else {
				word = _undefinedWord;
			}
			return (word);
		}
		
		public function get undefinedWord():String { return _undefinedWord; }
		
		public function set undefinedWord(value:String):void {
			_undefinedWord = value;
		}
		
	}
	
}