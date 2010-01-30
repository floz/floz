
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.wtf.misc 
{
	import com.wtf.engines.renderer.IRenderable;
	import flash.display.Sprite;
	
	public class MovieBitmap extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _animations:Object;
		private var _currentAnimation:AnimatedBitmap;
		
		private var _isPlaying:Boolean;
		private var _currentFrameId:String;
		
		private var _currentExpositionTick:int;
		private var _expositionTime:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MovieBitmap() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_animations = { };
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Ajoute une animation.
		 * @param	animatedBitmap	AnimatedBitmap	L'objet AnimatedBitmap qui contient l'animation.
		 * @param	frameId	String	Le nom de l'animation. Permettra de la jouer par l'appel de la méthode play.
		 * @param	defaultFrame	La frame par défaut. Lorsque le personnage ne bougera plus, on tombera sur cette frame.
		 */
		public function addAnimatedBitmap( animatedBitmap:AnimatedBitmap, frameId:String, defaultFrame:int = 0 ):void
		{
			animatedBitmap.defaultFrame = defaultFrame;
			_animations[ frameId ] = animatedBitmap;
		}
		
		/**
		 * Joue l'animation.
		 * @param	frameId	String	Joue la séquence d'animation liée à l'id "frameId".
		 */
		public function play( frameId:String = "" ):void
		{
			if ( _isPlaying && frameId == _currentFrameId )
				return;
			
			_isPlaying = true;
			_currentExpositionTick = 0;
			
			if ( frameId != "" )
			{				
				while ( numChildren ) removeChildAt( 0 );
				_currentAnimation = _animations[ frameId ];
				if ( !_currentAnimation ) throw new Error( "L'id '" + frameId +"' n'existe pas." );
				addChild( _currentAnimation );
				
				_currentFrameId = frameId;
			}
		}
		
		/**
		 * Stoppe l'animation
		 */
		public function stop():void
		{
			_isPlaying = false;
			_currentAnimation.gotoFrame( _currentAnimation.defaultFrame );
		}
		
		/**
		 * Actualise l'animation en cours, si la méthode play a été précédemment appellée.
		 */
		public function update():void
		{
			if ( _isPlaying )
			{
				++_currentExpositionTick;
				if ( _currentExpositionTick >= _expositionTime ) 
				{
					_currentAnimation.update();
					_currentExpositionTick = 0;
				}
			}
		}
		
		/**
		 * Défini l'animation par défaut lorsque le personnage sera inactif.
		 * @param	frameId	String	Correspond à la séquence d'animation à jouer.
		 */
		public function setDefaultAnimation( frameId:String ):void
		{
			var defaultAnimation:AnimatedBitmap = _animations[ frameId ];
			if ( !defaultAnimation ) throw new Error( "L'id '" + frameId +"' n'existe pas." );
			_currentAnimation = defaultAnimation;
			
			while ( numChildren ) removeChildAt( 0 );
			_currentAnimation.gotoFrame( _currentAnimation.defaultFrame );
			addChild( _currentAnimation );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		/**
		 * La valeur expositionTime détermine combien de fois chaque image de l'animation doit se répéter.
		 * Autrement dit, combien de fois cette image doit être exposée.
		 */
		public function set expositionTime( value:int ):void
		{
			_expositionTime = value;
			_currentExpositionTick = 0;
		}
		public function get expositionTime():int { return _expositionTime; }
		
	}
	
}