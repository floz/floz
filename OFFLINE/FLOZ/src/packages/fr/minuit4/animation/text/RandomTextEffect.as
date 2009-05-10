
/**
* Written by :
* @author : Floz - Florian Zumbrunn
* Version log :
* 
* 28.08.08		1.0		Floz		+ Première version
*/
package fr.minuit4.animation.text 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class RandomTextEffect extends EventDispatcher
	{
		private static const LOWER_LETTERS:Array = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " " ];
		private static const UPPER_LETTERS:Array = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " " ];
		private static const NUMS:Array = [ "1", "2", "3", "4", "5", "6", "7", "8", "9" ];
		private static const SIGNS:Array = [ ".", ";", ":", "!", "?", "<", ">", "|", "[", "]", "(", ")", "{", "}", "'", "^", "/", "&", "²", "=", "+", "-" ];
		private static const LETTERS_NUMS:Array = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "1", "2", "3", "4", "5", "6", "7", "8", "9" ];
		private static const LETTERS_NUMS_SIGNS:Array = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ";", ":", "!", "?", "<", ">", "|", "[", "]", "(", ")", "{", "}", "'", "^", "/", "&", "²", "=", "+", "-" ];
		private static const LETTERS_NUMS_MIX:Array = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ];
		private static const LETTERS_NUMS_SIGNS_MIX:Array = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ";", ":", "!", "?", "<", ">", "|", "[", "]", "(", ")", "{", "}", "'", "^", "/", "&", "²", "=", "+", "-", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ];
		private static const NUMS_SIGNS:Array = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ";", ":", "!", "?", "<", ">", "|", "[", "]", "(", ")", "{", "}", "'", "^", "/", "&", "²", "=", "+", "-" ];
		
		private var str:String;
		private var field:TextField;
		private var time:int;
		private var type:String;
		private var cssClass:String;
		private var listChars:Array;
		private var timer:Timer;
		private var currentText:String;		
		private var currentCharIndex:int;
		
		public function RandomTextEffect( str:String, field:TextField, time:int, type:String, cssClass:String ):void
		{
			if ( !str.length || !field ) return;
			
			this.str = str;
			this.field = field;
			this.time = time;
			this.type = type;
			this.cssClass = cssClass;
			
			if ( type == "lowerLetters" ) listChars = LOWER_LETTERS;
			else if ( type == "upperLetters" ) listChars = UPPER_LETTERS;
			else if ( type == "nums" ) listChars = NUMS;
			else if ( type == "signs" ) listChars = SIGNS;
			else if ( type == "lettersNums" ) listChars = LETTERS_NUMS;
			else if ( type == "lettersNumsSigns" ) listChars = LETTERS_NUMS_SIGNS;
			else if ( type == "lettersNumsMix" ) listChars = LETTERS_NUMS_MIX; 
			else if ( type == "lettersNumsSignsMix" ) listChars = LETTERS_NUMS_SIGNS_MIX; 
			else if ( type == "numsSigns" ) listChars = NUMS_SIGNS;
			else 
			{
				trace ( type, "is unvailable as type param in RandomTextEffect. Please, refer to method comments." );
				return;
			}
			
			currentText = "";			
			field.text = generate();
			
			timer = new Timer( time / str.length, str.length );
			timer.addEventListener( TimerEvent.TIMER, onTimer );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			timer.start();
			
			//
			
			dispatchEvent( new Event( Event.INIT ) );
		}
			
		// EVENTS
		
		private function onTimer(e:TimerEvent):void 
		{
			if ( !field.hasEventListener( Event.ENTER_FRAME ) ) field.addEventListener( Event.ENTER_FRAME, onFrame );
			
			currentText += str.charAt( currentCharIndex );
			field.htmlText = "<span class=" + cssClass + ">" + currentText + generate() + "</span>";
			
			currentCharIndex++;
			
			//
			
			dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS ) );
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			field.removeEventListener( Event.ENTER_FRAME, onFrame );			
			timer.removeEventListener( TimerEvent.TIMER, onTimer );
			timer.removeEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			timer = null;
			
			field.text = str;
			
			str = null;
			currentText = null;
			
			//
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		private function onFrame(e:Event):void 
		{
			if ( !field || !field.parent ) remove();
			field.htmlText = "<span class=" + cssClass + ">" + currentText + generate() + "</span>";
		}
		
		// PRIVATE
		
		private function generate():String
		{
			var s:String = "";
			var i:int;
			var n:int = str.length - currentCharIndex - 1;
			for ( i; i < n; i++ )
				s += listChars[ int( Math.random() * listChars.length ) ];
			
			return s;
		}
		
		private function remove():void
		{
			field.removeEventListener( Event.ENTER_FRAME, onFrame );			
			timer.removeEventListener( TimerEvent.TIMER, onTimer );
			timer.removeEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			timer = null;
			
			currentText = null;
			str = null;
			
			//
			
			dispatchEvent( new Event( Event.DEACTIVATE ) );
		}
		
		// PUBLIC
		
		public function getText():String
		{
			return field.text;
		}
		
		/**
		 * Permet d'apply un effect de recherche de texte aléatoire.
		 * @param	str		String	Le texte final à fournir.
		 * @param	field	TextField	Le champs de texte sur lequel l'effet doit être appliqué.
		 * @param	time	int	La durée totale de l'effet.
		 * @param	type	String	Quels caractères sont utilisés pour l'effet aléatoire. Les différents paramètres possibles sont :
		 * 		- "lowerLetters"	Les lettres de l'alphabet en minuscule.
		 * 		- "upperLetters"	Les lettres de l'alphabet en majuscule.
		 * 		- "nums"	Les nombres.
		 * 		- "signs"	Différents signes, les plus courramment utilisés.
		 * 		- "lettersNums"	Les lettres et les chiffres.
		 * 		- "lettersNumsSigns"	Les lettres, les chiffres et les signes.
		 * 		- "lettersNumsMix"	Les lettres -minuscules et majuscules- et les chiffres.
		 * 		- "lettersNumsSignsMix"	Les lettres -minuscules et majuscules-, les chiffres et les signes.
		 * 		- "numsSigns"	Les nombres et les signes.
		 */
		public static function apply( str:String, field:TextField, time:int = 3000, type:String = "lowerLetters", cssClass:String = "" ):RandomTextEffect
		{
			return new RandomTextEffect( str, field, time, type, cssClass );
		}
	}
	
}