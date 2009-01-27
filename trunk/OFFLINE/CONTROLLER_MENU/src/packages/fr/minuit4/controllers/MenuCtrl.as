
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 * 
 * Version log :
 * 
 * 27/01/09		1.0(bêta)		Floz	+Première version 
 */
package fr.minuit4.controllers 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public class MenuCtrl extends EventDispatcher
	{
		/** Evènement déclenché lorsqu'une section vient d'être sélectionnée par l'utilisateur */
		public static const SECTION_SELECTED	:String = "section_selected";
		/** Evènement déclenché lorsque l'utilisateur a la souris cliquée (onPress) */
		public static const SECTION_PRESSED		:String = "section_pressed";
		/** Evènement déclenché lorsque l'utilisateur survol une des sections inscrite dans le controlleur de menu */
		public static const SECTION_OVER		:String = "section_over";
		/** Evènement déclenché lorsque l'utilisateur quitte le survol d'une des sections inscrite dans le controller de menu */
		public static const SECTION_OUT			:String = "section_out";
		
		private var _useHandCursor					:Boolean;
		private var _usePressMode					:Boolean;
		private var _dispatchOverStateWhenPressed	:Boolean;
		private var _sections						:Dictionary;
		private var _sectionsByID					:Dictionary;
		
		private var _stage	:Stage;
		
		private var _tempSection	:DisplayObject;
		private var _overSection	:DisplayObject;
		private var _currentSection	:DisplayObject;
		private var _pressed		:Boolean;
		private var _numSections	:int;
		private var _initialized	:Boolean;
		
		/**
		 * Outil qui permet de controller un menu et les évènements qui lui sont liés. 
		 * 
		 * @param	useHandCursor	Boolean	Définit l'état de la souris lorsque l'on passe en rollover sur un des objets.
		 * @param	usePressMode	Boolean
		 * @param	dispatchOverStateWhenPressed
		 */
		public function MenuCtrl( useHandCursor:Boolean = true, usePressMode:Boolean = true, dispatchOverStateWhenPressed:Boolean = true ) 
		{
			this._useHandCursor = useHandCursor;
			this._usePressMode = usePressMode;
			this._dispatchOverStateWhenPressed = dispatchOverStateWhenPressed;
			
			_sections = new Dictionary( false );
			_sectionsByID = new Dictionary( true );
		}
		
		// EVENTS
		
		private function onClick(e:MouseEvent):void 
		{
			_currentSection = e.currentTarget as DisplayObject;
			dispatchEvent( new Event( MenuCtrl.SECTION_SELECTED ) );
		}
		
		private function onDown(e:MouseEvent):void 
		{
			_stage = DisplayObject( e.currentTarget ).stage;
			if ( !_stage ) 
				return;
			
			_pressed = true;
			_tempSection = e.currentTarget as DisplayObject;
			
			dispatchEvent( new Event( MenuCtrl.SECTION_PRESSED ) );
			_stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if ( _pressed && !_dispatchOverStateWhenPressed ) 
				return;
			
			_overSection = e.target as DisplayObject;
			dispatchEvent( new Event( MenuCtrl.SECTION_OVER ) );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if ( _pressed && !_dispatchOverStateWhenPressed ) 
				return;
			
			_overSection = null;
			dispatchEvent( new Event( MenuCtrl.SECTION_OUT ) );
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			if ( e.target == _tempSection ) 
			{
				_currentSection = _tempSection;
				dispatchEvent( new Event( MenuCtrl.SECTION_SELECTED ) );
			}
			
			_pressed = false;
			_tempSection = null;			
		}
		
		// PRIVATE
		
		// PUBLIC
		
		/**
		 * Associe un menu au controller de menu.
		 * Tous les éléments de type SimpleButton/Sprite/MovieClip seront ajoutés et considérés comme rubrique.
		 * @param	menu	DisplayObjectContainer	Le conteneur de différentes sections à considérées et traitées comme menu.
		 */
		public function linkToMenu( menu:DisplayObjectContainer ):void
		{
			var section:DisplayObject;			
			var name:String;
			
			var n:int = menu.numChildren;
			for ( var i:int; i < n; i++ )
			{
				section = menu.getChildAt( i );
				if ( !( section is SimpleButton || section is Sprite ) ) 
					continue;
				
				var id:int = _numSections + 1;
				
				this._sections[ section ] = false;
				this._sectionsByID[ id ] = section;
				this._numSections++;
			}
		}
		
		/**
		 * Associe un SimpleButton/Sprite/MovieClip au controller de menu.
		 * @param	section	Le DisplayObject à ajouter au controller de menu.
		 */
		public function linkToSection( section:DisplayObject ):void
		{
			if ( !( section is SimpleButton || section is Sprite ) ) 
				return;
			
			var id:int = _numSections + 1;
			
			this._sections[ section ] = false;
			this._sectionsByID[ id ] = section;
			this._numSections++;
		}
		
		/**
		 * Initialise les évènements sur les sections non initialisées.
		 */
		public function activate( initOnFirstSection:Boolean = false ):void
		{
			if ( !_initialized ) 
				_initialized = true;
			
			var ref:Object;
			for ( ref in _sections )
			{				
				if ( _sections[ ref ].init ) 
					continue;
				
				if ( _useHandCursor && ref is Sprite ) 
				{
					Sprite( ref ).buttonMode = true;
					Sprite( ref ).useHandCursor = true;
				}
				
				if ( _usePressMode ) DisplayObject( ref ).addEventListener( MouseEvent.MOUSE_DOWN, onDown );
				else DisplayObject( ref ).addEventListener( MouseEvent.CLICK, onClick );
				DisplayObject( ref ).addEventListener( MouseEvent.MOUSE_OVER, onOver );
				DisplayObject( ref ).addEventListener( MouseEvent.MOUSE_OUT, onOut );
				
				_sections[ ref ] = true;
			}
		}
		
		/**
		 * Permet de savoir si une section est actuellement liée ou non au controlleur.
		 * @param	section	DisplayObject	La section dont on se demande si elle est liée ou non au controlleur.
		 * @return
		 */
		public function isSectionLinked( section:DisplayObject ):Boolean
		{
			if ( !( section is SimpleButton || section is Sprite ) ) return false;
			if ( !_sections[ section ] ) return false;
			
			return true;
		}
		
		public function getSection( section:DisplayObject ):DisplayObject
		{
			if ( !( section is SimpleButton || section is Sprite ) || !_sections[ section ] ) 
				return null
			
			return _sections[ section ];
		}
		
		public function getSectionByID( id:int ):DisplayObject
		{
			if ( !_sectionsByID[ id ] ) 
				return null;
			
			return _sectionsByID[ id ];
		}
		
		// GETTERS & SETTERS
		
		/** Retourne la section actuellement sélectionné (DisplayObject) */
		public function get currentSection():DisplayObject { return this._currentSection; }
		
		/** Retourne la section actuellement survollée (DisplayObject) */
		public function get overSection():DisplayObject
		{
			if ( !_overSection ) return null;
			return this._overSection;
		}
		
		/** Retourne un booléen permettant de savoir si l'utilisateur est en état MOUSE_DOWN ou non */
		public function get pressed():Boolean { return this._pressed; }	
		
		/** Retourne le nombre de sections liées au contrôleur de menu */
		public function get numSections():int { return this._numSections; }
		
	}
	
}