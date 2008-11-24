/**
 * @author	: Arno - Arnaud NICOLAS
 * Version	: 1.0
 * Name		: textDecoding
 * Decription	: Class d'animation d'un champ texte, émule le décriptage d'un string
 * Exemple	:
 * 		import fr.minuit4.effects.textDecoding;
 * 		import flash.text.TextField;
 * 		var t:TextField = new TextField();
 * 		t.text = "Hellow World !";
 * 		addChild(t);
 * 		textDecoding.applyTo(t,t.text,{time:3000});
 */
package fr.minuit4.effects 
{
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class textDecoding extends EventDispatcher
	{
		
		private var chars:Array = ["_","-","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
		private var _target:TextField;
		private var _targetText:String;
		private var _active:Boolean;
		private var _currentCharIndex:int = 0;
		private var _currentText:String = "";
		private var _properties:Object;
		
		/**
		 * Constructeur
		 * Dispatch l'évènement Event.INIT sur l'animation textDecoding
		 * @param	pTxt		TextField		TextField cible
		 * @param	pString		String			Texte à décoder
		 * @param	pParams		Object			Paramètres d'un effet textDecoding
		 * 
		 * Paramètres attendus : time	int		temps d'animation en millisecondes
		 */
		public function textDecoding(pTxt:TextField, pString:String, pParams:Object):void
		{
			if (pTxt == null || !pString.length || !pParams.time || pParams.time == null) return;
			_properties = {};
			for (var i:String in pParams)
				if (i != "time") _properties[i] = pParams[i];
			
			dispatchEvent(new Event(Event.INIT));
			_target = pTxt;
			_targetText = pString;
			target.text = "";
			var t:Timer = new Timer((pParams.time/pString.length), pString.length);
			t.addEventListener(TimerEvent.TIMER, updateText);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, endOfTextDecoding);
			t.start();
		}
		
		
		/**
		 * Méthode static de création d'une nouvelle animation de textDecoding
		 * @param	pTxt		TextField		TextField cible
		 * @param	pString		String			Texte à décoder
		 * @param	pParams		Object			Paramètres d'un effet textDecoding
		 * @return	textDecoding				Nouvel objet d'animation textDecoding
		 */
		static public function applyTo(pTxt:TextField, pString:String, pParams:Object):textDecoding
		{
			return new textDecoding(pTxt, pString, pParams);
		}
		
		
		/**
		 * Méthode privée de mise à jour du textField
		 * Dispatch l'évènement ProgressEvent.PROGRESS
		 * @param	e		TimerEvent
		 */
		private function updateText(e:TimerEvent):void
		{
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
			_active = true;
			if (_targetText.charAt((_currentCharIndex - 1))) _currentText += _targetText.charAt(_currentCharIndex-1);
			_target.removeEventListener(Event.ENTER_FRAME, rollingchars);
			_target.addEventListener(Event.ENTER_FRAME, rollingchars);
			_target.text = _currentText;
			if (_properties["TextFormat"]) target.setTextFormat(_properties["TextFormat"]);
			_currentCharIndex++;
		}
		
		
		/**
		 * Méthode privée appelée une fois que l'animation textDecoding est finie
		 * Dispatch l'évènement Event.COMPLETE
		 * @param	e		TimerEvent
		 */
		private function endOfTextDecoding(e:TimerEvent):void
		{
			var t:Timer = e.target as Timer;
			t.removeEventListener(TimerEvent.TIMER, updateText);
			t.removeEventListener(TimerEvent.TIMER_COMPLETE, endOfTextDecoding);
			target.removeEventListener(Event.ENTER_FRAME, rollingchars);
			target.appendText(targetText.charAt(_currentCharIndex - 1));
			if (_properties["TextFormat"]) target.setTextFormat(_properties["TextFormat"]);
			_active = false;
			dispatchEvent(new Event(Event.COMPLETE));
			remove();
		}
		
		
		/**
		 * Méthode privée définit sur l'évènement ENTER_FRAME, donne l'effet de roulement de caractères
		 * @param	e		Event
		 */
		private function rollingchars(e:Event):void 
		{
			target.text = _currentText + chars[Math.round(Math.random() * (chars.length - 1))];
			if (_properties["TextFormat"]) target.setTextFormat(_properties["TextFormat"]);
		}
		
		
		/**
		 * Méthode de suppression des variables;
		 */
		private function remove():void
		{
			chars = null;
			_target = null;
			_targetText = null;
			_currentText = null;
			_properties = null;
			_active = undefined;
			_currentCharIndex = NaN;
		}
		
		// GETTER
		
		public function get target():TextField { return _target; }
		
		public function get targetText():String { return _targetText; }
		
		public function get active():Boolean { return _active; }
	}
	
}