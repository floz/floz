
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 * 
 * CHANGE LOG :
 * 
 * 12/07/09		0.1		Floz		+ Création de la première version de M4Tween.
 */
package fr.minuit4.motion 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import fr.minuit4.motion.easing.Linear;
	
	public class M4Tween 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		/** Le nombre de tweens créées chaque fois qu'il n'y en a plus de disponibles dans la liste. */
		private static const GROWTH_RATE:int = 0x10;
		/** Les paramètres réservés au fonctionnement de M4Tween. */
		private static const RESERVED_PARAMS:Object = { delay: 0, easing: 0, onInit: 0, onUpdate: 0, onComplete: 0, onInitParams: 0, onUpdateParams: 0, onCompleteParams: 0 };
		
		/** Recense toutes les tweens créées en fonction de leur cible. */
		private static var _tweensByTarget:Dictionary = new Dictionary( false );
		/** Indique si le moteur de tween est initialisé (si la méthode initiliaze a été appellée ou non) */
		private static var _initialized:Boolean;
		
		/** Permet de gérer le ENTER_FRAME event. */
		private static var _tweensController:Sprite;
		/** Permet de savoir si la méthode startEngine a été appellée, et donc si l'ENTER_FRAME se joue bien. */
		private static var _engineStarted:Boolean;
		/** Contient la valeur de getTimer, rafraichit à chaque frame par secondes. */
		private static var _currentTime:int;
		
		private static var _allowInstanciation:Boolean;
		private static var _availableInPool:int;
		private static var _currentTween:M4Tween;
		private static var _firstTween:M4Tween;
		private static var _lastTween:M4Tween;
		
		private var _prev:M4Tween;
		private var _next:M4Tween;
		
		private var _target:Object;
		private var _duration:Number;
		private var _params:Object;
		private var _tweensInfos:M4TweenInfos;
		private var _enabled:Boolean;
		private var _startTime:Number;
		private var _endTime:Number;
		private var _easing:Function;
		private var _delay:Number;
		private var _hasUpdate:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function M4Tween() 
		{
			if( !_allowInstanciation )
				throw new Error( "This class cannot be instanciated, use the createTween method instead." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		/** Rafraichit chaque tween actuellement en liste. */
		private static function render( e:Event ):void
		{
			_currentTime = getTimer();
			updateAllTweens();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/** Lance le moteur : déclenche l'évènement ENTER_FRAME. */
		private static function startEngine():void
		{
			if ( _engineStarted ) return;
			
			_tweensController.addEventListener( Event.ENTER_FRAME, M4Tween.render, false, 0, true );
			_engineStarted = true;
		}
		
		/** Stop le moteur : stop l'évènement ENTER_FRAME. */
		private static function stopEngine():void
		{
			if ( !_engineStarted ) return;
			
			_tweensController.removeEventListener( Event.ENTER_FRAME, render );
			_engineStarted = false;
		}
		
		/** Rafraichit toutes les tweens actuellement en liste. */
		private static function updateAllTweens():void
		{
			var tween:M4Tween = _firstTween;
			while ( tween && tween._enabled ) // tween._enabled seulement ?
			{
				tween.update();
				tween = tween._next;
			}
		}
		
		/**
		 * Cette méthode se charge d'initialiser la tween nouvellement créée.
		 * @param	target	Object	L'object qui va être tweené.
		 * @param	duration	Number	La durée totale de la tween en secondes.
		 * @param	params	Object	Les paramètres supplémentaires pour la définition de la tween (x, y, z... delay, onComplete, onUpdate, easing...)
		 */
		private function initialize( target:Object, duration:Number, params:Object ):void
		{
			this._target = target;
			this._duration = duration;
			this._params = params;
			
			_tweensInfos = new M4TweenInfos();
			var tweenInfos:M4TweenInfos = _tweensInfos;
			
			var property:String;
			for ( property in params )
			{
				if ( !( property in RESERVED_PARAMS ) )
				{
					tweenInfos.property = property;
					tweenInfos.startValue = _target[ property ];
					tweenInfos.endValue = params[ property ];
					
					tweenInfos = tweenInfos.next = new M4TweenInfos();
				}
			}
			
			_delay = params.delay || 0;
			_easing = typeof( params.easing ) == "function" ? params.easing : Linear.easeIn;
			_hasUpdate = params.onUpdate ? true : false;
			_startTime = getTimer() + _delay * 1000;
			_endTime = _startTime + _duration * 1000;
			
			this._enabled = true;
		}
		
		/** Met à jours les différents paramètres de la cible tweenée. */
		private function update():void
		{
			if ( _currentTime < _startTime )
				return;
			
			var t:Number; // Specifies the current time, between 0 and duration inclusive. 
			var b:Number; // Specifies the initial value of the animation property. 
			var c:Number; // Specifies the total change in the animation property. 
			var d:Number; // Specifies the duration of the motion.
			
			var value:Number;
			
			var tweenInfos:M4TweenInfos = _tweensInfos;
			var count:int;
			while ( tweenInfos && tweenInfos.property )
			{
				if ( !tweenInfos.complete )
				{
					if ( _currentTime >= _startTime )
					{
						t = _currentTime - _startTime;
						b = tweenInfos.startValue;
						c = tweenInfos.endValue - tweenInfos.startValue;
						d = _duration * 1000;
						value = _easing( t, b, c, d );
						
						_target[ tweenInfos.property ] = value;
						
						if ( _hasUpdate )
							_params.onUpdate.apply( null, _params.onUpdateParams );
						
						if ( _currentTime >= _endTime )
						{
							_target[ tweenInfos.property ] = tweenInfos.endValue;
							tweenInfos.complete = true;
							
							continue;
						}
						++count;
					}
				}
				tweenInfos = tweenInfos.next;
			}
			
			if ( !count )
			{
				if ( _params.onComplete )
					_params.onComplete.apply( null, _params.onCompleteParams );
				
				_enabled = false;
				_tweensInfos = null;
			}
		}
		
		/** Libère la mémoire en nettoyant les différents références aux objets. */
		private function clean():void
		{
			_prev =	_next = null;
			
			_tweensInfos = null;
			_target = null;
			_params = null;
			_easing = null;
			
			_enabled = false;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Méthode appellée pour initialiser la liste des tweens disponibles.
		 * Elle est facultative : elle sera de toute manière lancer automatiquement par le moteur, si cela n'a pas été fait.
		 * En revanche, s'il est prévu de créer un nombre élevé de tweens, il peut être intéressant, d'un point de vue des performances,
		 * de passer par celle ci.
		 * @param	tweensCount	int	Le nombre de tweens à créer.
		 */
		public static function initialize( tweensCount:int = -1 ):void
		{
			if ( tweensCount < 0 )
				tweensCount = GROWTH_RATE;
			
			_tweensController = new Sprite();
			
			_allowInstanciation = true;
			
			var tween:M4Tween = new M4Tween();
			_lastTween = tween;	
			var i:int = tweensCount;
			while ( --i > -1 )
			{
				tween._next = _currentTween;
				_currentTween = tween;
				
				if( i > 0 ) tween = tween._prev = new M4Tween();
			}
			_allowInstanciation = false;
			_firstTween = _currentTween;
			
			startEngine();
			
			_availableInPool = tweensCount;
			_initialized = true;
		}
		
		/**
		 * Méthode de création d'une tween.
		 * Après l'appel de cette méthode, la tween créée sera jouée.
		 * @param	target	Object	L'object qui va être tweené.
		 * @param	duration	Number	La durée totale de la tween en secondes.
		 * @param	params	Object	Les paramètres supplémentaires pour la définition de la tween (x, y, z... delay, onComplete, onUpdate, easing...)
		 * @return M4Tween	La tween qui vient d'être créée.
		 */
		public static function create( target:Object, duration:Number, params:Object ):M4Tween
		{
			if ( duration <= 0 )
				duration = 0.001;
			
			if ( !_initialized )
				initialize( GROWTH_RATE );
			
			var tween:M4Tween;
			if ( target in _tweensByTarget )
			{
				tween = _tweensByTarget[ target ];
				tween.initialize( target, duration, params );
				
				return tween;
			}
			
			if ( !_availableInPool )
			{
				_allowInstanciation = true;
				
				var oldLastTween:M4Tween = _lastTween;
				tween = new M4Tween();
				_lastTween = tween;
				
				var i:int = GROWTH_RATE;
				while ( --i > -1 )
				{
					tween._next = _currentTween;
					_currentTween = tween;
					
					if ( i > 0 ) tween = tween._prev = new M4Tween();
				}
				_allowInstanciation = false;
				tween._prev = oldLastTween;
				oldLastTween._next = tween;
				
				_availableInPool = GROWTH_RATE;
			}
			
			tween = _currentTween;
			_currentTween = tween._next;
			--_availableInPool;
			
			tween.initialize( target, duration, params );
			_tweensByTarget[ target ] = tween;
			
			return tween;			
		}
		
		/**
		 * Libère la tween passée en paramètre.
		 * @param	tween	La tween qui doit être libérée.
		 */
		public static function release( tween:M4Tween ):void
		{
			if ( !( tween._target in _tweensByTarget ) )
				return;
			
			if ( tween == _lastTween )
			{
				_currentTween = _lastTween;
				++_availableInPool;
				
				return;
			}
			else if ( tween == _firstTween )
			{
				var newFirst:M4Tween = _firstTween._next;
				newFirst._prev = null;
				
				_firstTween = newFirst;
			}
			else
			{
				tween._prev._next = tween._next;
				tween._next._prev = tween._prev;
			}
			
			delete _tweensByTarget[ tween._target ];
			tween.clean();
			
			_lastTween._next = tween;
			tween._prev = _lastTween;
			_lastTween = tween;
			
			if ( !_currentTween )
				_currentTween = _lastTween;
			
			++_availableInPool;
		}
		
		/**
		 * Relache la tween de l'objet passé en paramètre.
		 * @param	target	Object	L'objet qui a été tweené.
		 */
		public static function releaseTweenOf( target:Object ):void
		{
			release( _tweensByTarget[ target ] );
		}
		
		/**
		 * Supprime l'instance de tween.
		 * Revient à faire M4Tween.release( la tween en question );
		 */
		public function dispose():void
		{
			release( this );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}