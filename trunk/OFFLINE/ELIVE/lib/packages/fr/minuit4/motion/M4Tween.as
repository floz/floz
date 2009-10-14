/*** Written by :* @author Floz* www.floz.fr || www.minuit4.fr *  * CHANGE LOG : *  * 03/10/09		0.1		Floz		+ Impl�mentation d'une liste d'objet (Object pool). * 02/10/09		0.1		Floz		+ Refonte de M4Tween en tirant des le�ons de Eaze de Philippe Elsass. * 12/07/09		0.1		Floz		+ Cr�ation de la premi�re version de M4Tween. */package fr.minuit4.motion{	import flash.display.Shape;	import flash.events.Event;	import flash.utils.Dictionary;	import flash.utils.getTimer;	public class M4Tween	{		// ------------------------------------------------------------------------ ENGINE				// - PRIVATE VARIABLES -----------------------------------------------------------				private static const _renderer:Shape = startEngine();		private static var _tweens:M4Tween;		private static const _defaultEase:Function = QuadEaseOut;				private static const _runningTweens:Dictionary = new Dictionary( false );				private static var _allowInstanciation:Boolean = false;		private static var _tweensPool:M4Tween;		private static var _availableInPool:uint;				// - PUBLIC VARIABLES ------------------------------------------------------------				/**		 * Le nombre de tween � instancier � chaque remplissable de la liste de tweens disponibles.		 */		public static var growthRate:uint = 0x10;				// - EVENTS HANDLERS -------------------------------------------------------------				private static function renderTweens( e:Event ):void		{			if( _tweens ) updateTweens( getTimer() );		}				// - PRIVATE METHODS -------------------------------------------------------------				private static function startEngine():Shape		{			var renderer:Shape = new Shape();			renderer.addEventListener( Event.ENTER_FRAME, renderTweens );			return renderer;		}				/**		 * Update toutes les tweens inscrite � la liste des tweens � updater.		 * @param time	int	La valeur du temps interne actuelle.		 */		private static function updateTweens( time:int ):void		{			var isComplete:Boolean;			var property:M4TweenProperty;			var factor:Number, currentTweenTime:Number;			var t:M4Tween, tween:M4Tween = _tweens;			while( tween )			{				if( time < tween._startTime )				{					tween = tween._next;					 continue;				}								isComplete = time > tween._endTime;				currentTweenTime = time - tween._startTime;				factor = !isComplete ? tween._ease( currentTweenTime, 0, 1, tween._duration ) : 1;								property = tween._properties;				while( property )				{					tween._target[ property.name ] = property.startValue + ( factor * property.delta );					property = property.next;				}								if ( tween._updateHandler != null )					tween._updateHandler.apply( null, tween._updateArgs );								if( isComplete )				{									if ( tween._completeHandler != null )						tween._completeHandler.apply( null, tween._completeArgs );											t = tween._next;					tween.dispose();					tween = t;				}				else tween = tween._next;			}		}				/**		 * Enregistre une tween � la liste des tweens � updater.		 * @param tween	M4Tween	La tween � ajouter.		 */		private static function registerTween( tween:M4Tween ):void		{			if( _tweens ) _tweens._prev = tween;			tween._next = _tweens;			_tweens = tween;						var existingTween:M4Tween = _runningTweens[ tween._target ];			if( existingTween )			{				existingTween.dispose();				delete( _runningTweens[ tween._target ] );			}						_runningTweens[ tween._target ] = tween;		}				/**		 * D�sinscris une tween � la liste des tweens � updater.		 * @param tween	M4Tween	La tween � d�sinscrire.		 */		private static function unregisterTween( tween:M4Tween ):void		{			if ( !_runningTweens[ tween._target ] )				return;						var prev:M4Tween = tween._prev;			var next:M4Tween = tween._next;			if( prev ) 			{				prev._next = next;				if( next ) next._prev = prev;			}			else 			{				_tweens = next;				if( _tweens ) _tweens._prev = null;			}						delete _runningTweens[ tween._target ];		}				/**		 * Lib�re une tween pour permettre sa r�utilisation.		 * La tween lib�r�e sera ajout�e � la liste des tweens disponibles (Object Pooling).		 * @param tween	M4Tween	La tween � lib�rer.		 */		private static function release( tween:M4Tween ):void		{			tween._pnext = _tweensPool;			_tweensPool = tween;						++_availableInPool;		}				/**		 * Fonction d'animation par d�faut.		 */		private static function QuadEaseOut(t:Number, b:Number, c:Number, d:Number):Number		{			return -c *(t/=d)*(t-2) + b;		}		// - PUBLIC METHODS --------------------------------------------------------------				/**		 * Cr�e et lance la tween.		 * @param target	Object	L'objet sur lequel sera appliqu� la tween.		 * @param duration	Number	La dur�e totale de la tween, en secondes.		 * @param params	Object	Les param�tres de l'objet qui seront modifi�s par la tween.		 * @param delay	Number	Permet de mettre un d�lai avant le d�but de la tween, en secondes.		 * @return	M4Tween	La tween qui vient d'�tre cr��e.		 */		public static function to( target:Object, duration:Number, params:Object = null, delay:Number = 0 ):M4Tween		{			return create( target, duration, params, delay ).start();		}				/**		 * M�thode de cr�ation d'une tween. Peut �tre lanc�e avec la m�thode "start".		 * Pour cr�er et lancer directement une tween faites appel � la m�thode "to".		 * @param target	Object	L'objet sur lequel sera appliqu� la tween.		 * @param duration	Number	La dur�e totale de la tween, en secondes.		 * @param params	Object	Les param�tres de l'objet qui seront modifi�s par la tween.		 * @param delay	Number	Permet de mettre un d�lai avant le d�but de la tween, en secondes.		 * @return	M4Tween	La tween qui vient d'�tre cr��e.		 */		public static function create( target:Object, duration:Number, params:Object = null, delay:Number = 0 ):M4Tween		{			var tween:M4Tween;			if( _availableInPool == 0 )			{				var i:int = growthRate;				while( --i > -1 )				{					_allowInstanciation = true; {						tween = new M4Tween();					} _allowInstanciation = false;										tween._pnext = _tweensPool;					_tweensPool = tween;				}				_availableInPool = growthRate;			}						tween = _tweensPool;			_tweensPool = tween._pnext;			--_availableInPool;						tween.init( target, duration, params, delay );			return tween;		}				/**		 * Supprime la tween li�e � l'objet "target".		 * @param target	Object	L'objet sur lequel des tweens ont �t� appliqu�es.		 */		public static function killTweensOf( target:Object ):void		{			var tween:M4Tween = _runningTweens[ target ];			tween.dispose();			delete _runningTweens[ target ];		}				/**		 * Supprime toutes les tweens.		 * @param	purge	Boolean	Vide la liste des tweens disponibles. Lib�re totalement la m�moire.		 */		public static function killAllTweens( purge:Boolean = false ):void		{			for( var target:Object in _runningTweens )				killTweensOf( target );						if( !purge ) return;						var next:M4Tween, tween:M4Tween = _tweensPool;			while( tween )			{				next = tween._pnext;				tween._pnext = null;				tween = next;			}			_tweensPool = null;			_availableInPool = 0;		}				// ---------------------------------------------------------------------- INSTANCE				// - PRIVATE VARIABLES -----------------------------------------------------------				private var _target:Object;		private var _duration:Number;		private var _delay:Number;		private var _ease:Function;		private var _properties:M4TweenProperty;				private var _startTime:int;		private var _endTime:int;				private var _prev:M4Tween;		private var _next:M4Tween;				private var _pnext:M4Tween;				private var _startHandler:Function;		private var _startArgs:Array;		private var _updateHandler:Function;		private var _updateArgs:Array;		private var _completeHandler:Function;		private var _completeArgs:Array;				// - PUBLIC VARIABLES ------------------------------------------------------------				// - CONSTRUCTOR -----------------------------------------------------------------				public function M4Tween()		{			if( !_allowInstanciation ) throw new Error( "Impossible d'instancier une tween en passant par le constructeur. Appellez la m�thode 'create' ou 'to'." );		}				// - EVENTS HANDLERS -------------------------------------------------------------				// - PRIVATE METHODS -------------------------------------------------------------				private function init( target:Object, duration:Number, params:Object = null, delay:Number = 0 ):void		{			_target = target;			_duration = duration * 1000;			_delay = delay * 1000;						if( params.ease && typeof( params.ease ) == "function" )			{				_ease = params.ease;				delete params.ease;			}			else _ease = _defaultEase;						for( var name:String in params )				_properties = new M4TweenProperty( name, params[ name ], _properties );		}				// - PUBLIC METHODS --------------------------------------------------------------				/**		 * D�clenche la tween cr��e.		 */		public function start():M4Tween		{			_startTime = getTimer() + _delay;			_endTime = _startTime + _duration;						var property:M4TweenProperty = _properties;			while( property )			{				property.init( _target );				property = property.next;			}						registerTween( this );						if( _startHandler != null )				_startHandler.apply( null, _startArgs );								return this;		}				/**		 * Ajoute un callback � la tween qui sera d�clench� au lancement de celle ci.		 * @param handler	Function	La fonction qui sera appell�e.		 * @param ...args	Array	Les param�tres � transmettre � la fonction.		 */		public function onStart( handler:Function, ...args ):M4Tween		{			_startHandler = handler;			_startArgs = args;			return this;		}				/**		 * Ajoute un callback � la tween qui sera d�clench� � chaque mise � jour de celle ci.		 * @param handler	Function	La fonction qui sera appell�e.		 * @param ...args	Array	Les param�tres � transmettre � la fonction.		 */		public function onUpdate( handler:Function, ...args ):M4Tween		{			_updateHandler = handler;			_updateArgs = args;			return this;		}				/**		 * Ajoute un callback � la tween qui sera d�clench� � la fin de celle ci.		 * @param handler	Function	La fonction qui sera appell�e.		 * @param ...args	Array	Les param�tres � transmettre � la fonction.		 */		public function onComplete( handler:Function, ...args ):M4Tween		{			_completeHandler = handler;			_completeArgs = args;			return this;		}				/**		 * Supprime les r�f�rences � la tween.		 */		public function dispose():void		{			unregisterTween( this );			release( this );						_prev = null;			_next = null;			_target = null;						if( _properties ) 			{				_properties.dispose();				_properties = null;			}						_startArgs = null;			_startHandler = null;			_updateArgs = null;			_updateHandler = null;			_completeArgs = null;			_completeHandler = null;		}				// - GETTERS & SETTERS -----------------------------------------------------------		}	}