
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.events.Event;
	import painting.brushes.IBrush;
	
	public class Canvas extends Bitmap
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _height:Number;
		private var _fillColor:Number;
		
		private var _brushes:Vector.<IBrush> = new Vector.<IBrush>( 10, true );
		private var _brushCount:int;
		
		private var _mouseDown:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Canvas( w:Number, h:Number, transparent:Boolean = false, fillColor:uint = 0xffffffff ) 
		{
			this._width = w;
			this._height = h;
			this._fillColor = fillColor;
			
			super( new BitmapData( w, h, transparent, fillColor ), PixelSnapping.AUTO, true );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
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
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function update():void
		{
			var i:int = _brushCount;
			while ( --i > -1 )
			{
				_brushes[ i ].update( stage.mouseX, stage.mouseY );
				this.bitmapData.draw( _brushes[ i ] );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addBrush( brush:IBrush ):void
		{
			if ( _brushCount == _brushes.length )
				throw new Error( "Pas plus de 4 brush admis." );
			
			if ( hasBrush( brush ) )
				throw new Error( "Brush déjà ajouté" );
			
			_brushes[ _brushCount ] = brush;
			++_brushCount;
		}
		
		public function removeBrush( brush:IBrush ):void
		{
			if ( !_brushCount || !hasBrush( brush ) )
				throw new Error( "Brush invalide" );
			
			_brushes[ getBrushIndex( brush ) ] = null;
			
			--_brushCount;
		}
		
		public function startPainting():void
		{
			if ( hasEventListener( Event.ENTER_FRAME ) )
				return;
			
			_mouseDown = true;
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		public function stopPainting():void
		{
			if ( !hasEventListener( Event.ENTER_FRAME ) )
				return;
			
			_mouseDown = false;
			removeEventListener( Event.ENTER_FRAME, onFrame );
			
			var i:int = _brushCount;
			while ( --i > -1 )
				_brushes[ i ].reset();
		}
		
		public function getBrushIndex( brush:IBrush ):int
		{
			return _brushes.indexOf( brush );
		}
		
		public function hasBrush( brush:IBrush ):Boolean
		{
			return getBrushIndex( brush ) != -1;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}