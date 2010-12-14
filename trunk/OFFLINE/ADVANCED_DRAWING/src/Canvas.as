
/**
 * @author Floz
 */
package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	public class Canvas extends Bitmap
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _width:Number;
		protected var _height:Number;
		protected var _fillColor:uint;
		protected var _brushes:Vector.<Brush>;
		
		protected var _continuous:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var capturing:Boolean;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Canvas( width:Number, height:Number, fillColor:uint ) 
		{
			this._width = width;
			this._height = height;
			this._fillColor = fillColor;
			
			super( null, "auto", true );
			
			_brushes = new Vector.<Brush>();
			
			bitmapData = new BitmapData( _width, _height, false, fillColor );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function enterFrameHandler(e:Event):void 
		{
			renderOnce();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addBrush( b:Brush ):void
		{
			_brushes[ _brushes.length ] = b;
		}
		
		public function startCapture( continuous:Boolean = false ):void
		{
			_continuous = continuous;
			
			if ( !capturing )
			{
				capturing = true;
				addEventListener( Event.ENTER_FRAME, enterFrameHandler, false, 0, true );
			}
		}
		
		public function stopCapture():void
		{
			if ( capturing )
			{
				capturing = false;
				removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
				
				var n:int = _brushes.length;
				for ( var i:int; i < n; ++i )
				{
					_brushes[ i ].stop();
				}
			}
		}
		
		public function renderOnce():void
		{
			if ( !_continuous )
				bitmapData.fillRect( bitmapData.rect, _fillColor );
			
			var n:int = _brushes.length;
			for ( var i:int; i < n; ++i )
			{
				_brushes[ i ].update( stage.mouseX, stage.mouseY );
				bitmapData.draw( _brushes[ i ], null );
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}