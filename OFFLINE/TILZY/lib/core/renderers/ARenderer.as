
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.core.renderers
{
	import flash.events.EventDispatcher;
	
	public class ARenderer extends EventDispatcher implements IRenderable
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		/**
		 * Contient tous les items à rendre.
		 * Les items étendent tous de l'interface IRenderable.
		 */
		protected var _renderables:Vector.<IRenderable>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ARenderer() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_renderables = new Vector.<IRenderable>();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function render( renderTime:Number ):void
		{
			var l:int = _renderables.length;
			while ( --l > -1 )
				_renderables[ l ].render( renderTime );
		}
		
		/**
		 * Enregistre un objet.
		 * L'objet enregistré sera updaté à chaque appel de la méthode render.
		 * @param	renderable	IRenderable	L'objet à enregistré
		 * @return	Boolean	Renvoie vrai si l'objet à été enregistré.
		 */
		public function register( renderable:IRenderable ):Boolean
		{
			if ( _renderables.indexOf( renderable, 0 ) != -1 )
				return false;
			
			var l:int = _renderables.length;
			return ( _renderables.push( renderable ) != _renderables.length );
		}
		
		/**
		 * Désenregistre un objet précis.
		 * @param	renderable	IRenderable	L'objet précisément enregistré.
		 * @return	Boolean	Renvoie si l'objet à été désenregistré avec succès ou non.
		 */
		public function unregister( renderable:IRenderable ):Boolean
		{
			var idx:int = _renderables.indexOf( renderable, 0 );
			if ( idx < -1 ) 
				return false;
			
			var l:int = _renderables.length;
			return ( _renderables.splice( idx, 1 ).length != l );
		}
		
		/**
		 * Vide totalement la liste des items enregistrés.
		 * On repart à zéro.
		 */
		public function unregisterAll():void
		{
			init();
		}
		
		/**
		 * Vide la liste des items et libère la mémoire.
		 * Après l'appel de la méthode dispose, l'objet est inutilisable.
		 */
		public function dispose():void
		{
			_renderables = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}