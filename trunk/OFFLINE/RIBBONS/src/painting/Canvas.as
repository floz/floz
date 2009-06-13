
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import painting.events.PaintingEvent;
	import painting.interfaces.IBrush;
	import painting.interfaces.IBrushManager;
	
	public class Canvas extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _height:Number;
		private var _transparent:Boolean;
		private var _fillColor:Number;		
		private var _canvas:Bitmap;
		private var _brushContainer:Sprite;
		
		private var _brushes:Vector.<IBrushManager> = new Vector.<IBrushManager>( 10, true );
		private var _brushCount:int;
		
		private var _painting:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Canvas( w:Number, h:Number, transparent:Boolean = false, fillColor:uint = 0xffffffff ) 
		{
			this._width = w;
			this._height = h;
			this._transparent = transparent;
			this._fillColor = fillColor;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onFrame( e:Event ):void
		{
			update();
		}
		
		private function onDraw(e:PaintingEvent):void 
		{
			_canvas.bitmapData.draw( e.instance );
			e.brushHolder.deleteInstance( e.instance );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_canvas = new Bitmap( new BitmapData( _width, _height, _transparent, _fillColor ), PixelSnapping.NEVER, false );
			addChild( _canvas );
			
			_brushContainer = new Sprite();
			addChild( _brushContainer );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function update():void
		{
			var runningBrushes:int;
			
			var i:int;
			var n:int = _brushCount;
			for ( ; i < n; ++i )
				runningBrushes += _brushes[ i ].update( stage.mouseX, stage.mouseY );
			
			if ( !runningBrushes && !_painting )
				removeEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Add a new brush to the canvas.
		 * @param	brush	IBrush	The brush instance.
		 */
		public function addBrush( brush:IBrushManager ):void
		{
			if ( _brushCount == _brushes.length )
				throw new Error( "No more " + _brushes.length + " allowed." );
			
			brush.addEventListener( PaintingEvent.DRAW, onDraw );
			
			_brushContainer.addChild( brush as DisplayObject );
			
			_brushes[ _brushCount ] = brush;
			++_brushCount;
		}
		
		/**
		 * Remove a brush that had been previously added.
		 * @param	brush	IBrush	The brush instance.
		 */
		public function removeBrush( brush:IBrushManager ):void
		{
			if ( !_brushCount || !hasBrush( brush ) )
				throw new Error( "Invalid Brush" );
			
			_brushContainer.removeChild( brush as DisplayObject );
			_brushes[ getBrushIndex( brush ) ] = null;
			
			--_brushCount;
		}
		
		/**
		 * Start painting.
		 */
		public function startPainting():void
		{
			if ( _painting )
				return;
			
			var n:int = _brushCount;
			for ( var i:int; i < n; ++i )
				_brushes[ i ].createInstance();
			
			_painting = true;
			
			if ( !hasEventListener( Event.ENTER_FRAME ) ) addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		/**
		 * Stop painting.
		 */
		public function stopPainting():void
		{
			if ( !_painting )
				return;
			
			_painting = false;
			
			var i:int = _brushCount;
			while ( --i > -1 )
				_brushes[ i ].releaseBrushes( stage.mouseX, stage.mouseY );
		}
		
		/**
		 * Return the index of the brush passed in parameter.
		 * @param	brush	IBrush	The brush instance
		 * @return
		 */
		public function getBrushIndex( brush:IBrushManager ):int
		{
			return _brushes.indexOf( brush );
		}
		
		/**
		 * Return true if the brush is already used.
		 * @param	brush	Boolean
		 * @return
		 */
		public function hasBrush( brush:IBrushManager ):Boolean
		{
			return getBrushIndex( brush ) != -1;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}