package com.bigarobas.utils.language {
	import com.bigarobas.manager.Manager;
	import com.bigarobas.manager.ManagerEvent;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class LanguageManager extends Manager {
		protected var _languages:Array;
		protected var _language:String = "";
		protected var _dictionary:LanguageDictionary;
		public function LanguageManager() {
			_languages = [];
			addEventListener(ManagerEvent.MEMBER_ADDED, onRegister);
		}
		
		protected function onRegister(e:ManagerEvent):void {
			if (e.content is ICosmopolite) {
				var member:ICosmopolite = e.content as ICosmopolite;
				if (_dictionary!=null){
					member.translate();
				}
			} else {
				throw (new Error("LanguageManager can only register ICosmopolit implemented Objects"));
				remove(e.content);
			}
		}
		
		public function addLanguage(vID:String, vDict:LanguageDictionary):void {
			_languages[vID] = vDict;
		}
		
		public function setLanguage(vID:String):void {
			if (_languages[vID] is LanguageDictionary) {
				_language = vID;
				_dictionary = _languages[_language];
				apply(forceTranslation);
			}
			
		}
		
		public function getDictionary(vID:String):LanguageDictionary {
			var dico:LanguageDictionary = null;
			if (_languages[vID] is LanguageDictionary) {
				dico = _languages[_language];
			}
			
			return (dico);
		}
		
		protected function forceTranslation(vIC:*):void {
			(vIC as ICosmopolite).translate();
		}
		
		public function getWord(vWordID:String):String {
			var word:String="";
			if (_dictionary) word = _dictionary.getWord(vWordID);
			return word;
		}
		
		public function get dictionary():LanguageDictionary { return _dictionary; }
		
		public function get language():String { return _language; }
		
		public function hasLanguage(vLanguageID:String):Boolean {
			return (_languages[vLanguageID] is LanguageDictionary);
		}
		
		
		
	}
	
}