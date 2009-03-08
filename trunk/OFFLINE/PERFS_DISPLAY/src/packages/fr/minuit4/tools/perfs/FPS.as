
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 
 * 08.03.09		1.1		Floz		+ Possibilité de déplacer le composant, et de cacher/afficher le graphique.
 * 08.03.09		1.0		Floz		+ Refonte pour ajout d'un graphique de performances
 * 28.08.08		0.9		Floz		+ Première version
 */
package fr.minuit4.tools.perfs 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class FPS extends Sprite
	{
		// - STATIC VARIABLES ------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _height:Number;
		private var _interval:int;
		private var _scroll:int;
		private var _memMax:int;
		private var _graph:Sprite;
		private var _infos:Sprite;
		private var _curves:BitmapData;
		
		private var _graphicShown:Boolean;
		private var _isRunning:Boolean;
		
		private var _prevFps:int;
		private var _prevMem:int;
		private var _rect:Rectangle;
		
		private var _tFps:TextField;
		private var _tMem:TextField;
		private var _tMs:TextField;
		
		private var _fps:Number = 0;
		private var _mem:Number = 0;
		private var _ms:Number;
		
		private var _count:int;
		private var _currentTime:int;
		private var _prevIntervalTime:int;
		private var _prevTime:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Permet de suivre les performances de l'application.
		 * Les FPS correspondent au nombre d'images par secondes affichées.
		 * "MEM" correspond à la mémoire physique utilisée par l'application (en mo).
		 * Les MS correspondent au nombre de millisecondes entre chaque rafraichissement. Plus le nombre de MS est grand, plus les 
		 * FPS sont petits, et plus l'application est lente.
		 * @param	width	Number	La largeur de la fenêtre.
		 * @param	height	Number	La hauteur de la fenêtre.
		 * @param	interval	int	Correspond au nombre de seconde entre chaque rafraichissement du graphique.
		 * @param	scroll	int	Correspond au nombre de pixels scrollés sur le graphique.
		 * @param	memMax	int	Correspond à la hauteur maximale du graphique (si memMax = 100, le graphique atteindra son "sommet" avec 100mo de ram utilisé).
		 */
		public function FPS( width:Number = 250, height:Number = 50, interval:int = 5, scroll:int = 2, memMax:int = 100 ) 
		{
			_width = width;
			_height = height;
			_interval = interval;
			_scroll = scroll;
			_memMax = memMax;
			
			var head:Bitmap = new Bitmap( new BitmapData( _width + 1, 20, true, 0xEE111111 ) );
			addChild( head );
			
			_graph = new Sprite();
			addChild( _graph );
			
			var background:Bitmap = drawBackground();
			background.y = head.height;
			_graph.addChild( background );
			
			_infos = new Sprite();
			addChild( _infos );
			
			_curves = new BitmapData( _width - 10, _height - 10, true, 0x00 );
			var curvesHolder:Bitmap = new Bitmap( _curves );
			curvesHolder.x = 5; curvesHolder.y = 25;
			_graph.addChild( curvesHolder );
			
			_prevFps =
			_prevMem = _curves.height;
			
			_rect = new Rectangle( _curves.width - _scroll, 0, _scroll, _curves.height );
			
			defineTexts();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			if ( hasEventListener( Event.ENTER_FRAME ) ) removeEventListener( Event.ENTER_FRAME, renderCurves );
			removeEventListener( Event.DEACTIVATE, onDeactivate );
			removeEventListener( Event.ACTIVATE, onActivate );
			
			_curves.dispose();
			_curves = null;
			
			while ( _graph.numChildren ) _graph.removeChildAt( 0 );
			while ( _infos.numChildren ) _infos.removeChildAt( 0 );
			while ( numChildren ) removeChildAt( 0 );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			addEventListener( Event.DEACTIVATE, onDeactivate );
			addEventListener( Event.ACTIVATE, onActivate );
			
			addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			addEventListener( MouseEvent.MOUSE_UP, onUp );
			
			var doubleClickZone:Sprite = new Sprite();
			doubleClickZone.addChild( new Bitmap( new BitmapData( _width + 1, 20, true, 0x00 ) ) );
			doubleClickZone.addEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick );
			addChild( doubleClickZone );
			
			doubleClickZone.doubleClickEnabled =
			doubleClickZone.buttonMode =
			_graphicShown = true;
			
			addEventListener( Event.ENTER_FRAME, renderCurves );
			_isRunning = true;
		}
		
		private function onDeactivate(e:Event):void 
		{
			pause();
		}
		
		private function onActivate(e:Event):void 
		{
			play();
		}
		
		private function onDown(e:MouseEvent):void 
		{
			startDrag();
		}
		
		private function onUp(e:MouseEvent):void 
		{
			stopDrag();
		}
		
		/** Affiche ou cache le graphique */
		private function onDoubleClick(e:MouseEvent):void 
		{
			_graph.visible =
			_graphicShown = !_graphicShown;			
		}
		
		/** Actualise les informations */
		private function renderCurves(e:Event):void 
		{
			_currentTime = getTimer();
			
			if ( _count++ >+ _interval )
			{
				_fps = int( ( 1000 * _count ) / ( _currentTime - _prevIntervalTime ) );
				_count = 0;
				_prevIntervalTime = _currentTime;
				
				_mem = int( System.totalMemory / 1048576 );
				
				if ( _graphicShown )
				{
					_curves.scroll( -_scroll, 0 );
					_curves.fillRect( _rect, 0x00 );
					
					var rf:Number = Math.min( 1, _fps / stage.frameRate );
					var nextFps:int = ( 1 - rf ) * ( _curves.height - 1 );
					drawLine( _curves.width - _scroll, _prevFps, _curves.width - 1, nextFps, 0xffff0000 );
					_prevFps = nextFps;
					
					var rm:Number = Math.min( 1, _mem / _memMax );
					var nextMem:int = ( 1 - rm ) * ( _curves.height - 1 );			
					drawLine( _curves.width - _scroll, _prevMem, _curves.width - 1, nextMem, 0xff00ff00 );
					_prevMem = nextMem;
				}
			}
			
			_ms = int( _currentTime - _prevTime );
			_prevTime = _currentTime;
			
			refreshTexts();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/** Dessine le background */
		private function drawBackground():Bitmap
		{
			var bd:BitmapData = new BitmapData( _width + 1, _height + 1, true, 0x00 );
			
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.lineStyle( 1, 0xe5e5e5 );
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, _width, _height );
			g.endFill();
			
			bd.draw( s );
			
			s = new Shape();
			g = s.graphics;
			g.beginGradientFill( GradientType.LINEAR, [ 0xffffff, 0xeeeeee ], [ 1, 1 ], [ 0, 255 ] );
			g.drawRect( 5, 5, _width - 10, _height - 10 );
			g.endFill();			
			
			bd.draw( s );
			g = null;
			s = null;
			
			return new Bitmap( bd );
		}
		
		/** Définit les différents champs de textes */
		private function defineTexts():void
		{
			var tf:TextFormat = new TextFormat( "_sans", 9 );
			
			_tFps = new TextField();
			_tFps.x = 5; _tFps.y = 2;
			_tMem = new TextField();
			_tMem.x = 75; _tMem.y = 2;
			_tMs = new TextField();
			_tMs.x = _width - 50; _tMs.y = 2;
			
			_tFps.textColor = 0xff0000;
			_tMem.textColor = 0x00ff00;
			_tMs.textColor = 0xffffff;
			
			_tFps.selectable = 
			_tMem.selectable =
			_tMs.selectable = false;
			
			_tFps.defaultTextFormat =
			_tMem.defaultTextFormat =
			_tMs.defaultTextFormat = tf;
			
			refreshTexts();
			
			_infos.addChild( _tFps );
			_infos.addChild( _tMem );
			_infos.addChild( _tMs );
		}
		
		/** Rafraichit les textes FPS/MEM/MS */
		private function refreshTexts():void
		{
			if ( !_isRunning )
			{
				_tFps.text = "FPS : ...";
				_tMem.text = "MEM : ...";
				_tMs.text = "MS : ...";
				
				return;
			}
			_tFps.text = "FPS : " + _fps.toString() + " / " + stage.frameRate;
			_tMem.text = "MEM : " + _mem.toString();
			_tMs.text = "MS : " + _ms.toString();
		}
		
		/**
		 * Dessine une ligne bien pixelisée.
		 * @param	x0	int	Le point de départ sur l'axe des x.
		 * @param	y0	int	Le point de départ sur l'axe des y.
		 * @param	x1	int	Le point d'arrivée sur l'axe des x.
		 * @param	y1	int	Le point d'arrivée sur l'axe des y.
		 * @param	c	int	La couleur de la courbe à tracer.
		 */
		private function drawLine( x0:int, y0:int, x1:int, y1:int, c:uint = 0xff000000 ):void
		{
			var dx:int = x1 - x0;
			var dy:int = y1 - y0;
			var xinc:int = ( dx > 0 ) ? 1 : -1;
			var yinc:int = ( dy > 0 ) ? 1 : -1;
			dx = Math.abs( dx );
			dy = Math.abs( dy );
			
			_curves.setPixel32( x0, y0, c );
			
			var cumul:int;
			var i:int;
			if ( dx > dy )
			{
				cumul = dx >> 1;
				for ( i = 1; i <= dx; i++ )
				{
					x0 += xinc;
					cumul += dy;
					if ( cumul >= dx )
					{
						y0 += yinc;
						cumul -= dx;
					}
					_curves.setPixel32( x0, y0, c );
				}
			}
			else
			{
				cumul = dy >> 1;
				for ( i = 1; i <= dy; i++ )
				{
					y0 += yinc;
					cumul += dx;
					if ( cumul >= dy )
					{
						x0 += xinc;
						cumul -= dy;
					}
					_curves.setPixel32( x0, y0, c );
				}
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/** Met le composant en pause */
		public function pause():void
		{
			if ( !_isRunning ) return;
			
			removeEventListener( Event.ENTER_FRAME, renderCurves );
			_isRunning = false;
			
			refreshTexts();
		}
		
		/** Lance/relance le composant */
		public function play():void
		{
			if ( _isRunning ) return;
			
			addEventListener( Event.ENTER_FRAME, renderCurves );
			_isRunning = true;
		}
		
		/** Permet de savoir si le composant est actif ou non */
		public function isRunning():Boolean { return _isRunning; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}