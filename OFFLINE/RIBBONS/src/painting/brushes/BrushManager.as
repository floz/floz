
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import painting.brushes.ribbons.Ribbon;
	import painting.events.PaintingEvent;
	import painting.interfaces.IBrush;
	import painting.interfaces.IBrushManager;
	
	public class BrushManager extends Sprite implements IBrushManager
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _ribbonsDatas:Vector.<IBrush>;
		
		private var _brushComplete:PaintingEvent;
		
		private var _painting:Boolean;
		private var _active:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function BrushManager() 
		{
			_ribbonsDatas = new Vector.<IBrush>();
			
			_painting = true;
			_active = true;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_brushComplete = new PaintingEvent( PaintingEvent.BRUSH_COMPLETE, true );
			_brushComplete.brushHolder = this;
		}
		
		private function onBrushComplete(e:PaintingEvent):void 
		{
			var instance:Sprite = e.instance;
			
			var i:int = instance.numChildren;
			while ( --i > -1 )
			{
				instance.getChildAt( i ).removeEventListener( PaintingEvent.BRUSH_COMPLETE, onBrushComplete );
				( instance.getChildAt( i ) as IBrush ).enabled = false;
			}
			
			var drawEvent:PaintingEvent = new PaintingEvent( PaintingEvent.DRAW, true );
			drawEvent.instance = instance;
			drawEvent.brushHolder = this;
			dispatchEvent( drawEvent );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update( mx:Number, my:Number ):int
		{
			if ( !numChildren || !_active )
				return 0;
			
			var count:int;
			
			var instance:Sprite;
			var ribbon:IBrush;
			
			var drawEvent:PaintingEvent = new PaintingEvent( PaintingEvent.DRAW, true );
			
			var j:int;
			var i:int = numChildren;
			while( --i > -1 )
			{
				instance = getChildAt( i ) as Sprite
				j = instance.numChildren;
				
				while( --j > -1 )
				{
					ribbon = instance.getChildAt( j ) as IBrush;
					
					if ( !ribbon.released )
					{
						ribbon.paint( mx, my );
						++count;
					}
					else
						count += ribbon.completePainting();
				}
			}
			
			return count;
		}
		
		public function addBrush( brush:IBrush ):void
		{
			_ribbonsDatas.push( brush );
		}
		
		public function removeBrush( brush:IBrush ):void
		{
			if ( !hasBrush( brush ) ) return;
			_ribbonsDatas.splice( getBrushIndex( brush ), 1 );
		}
		
		public function releaseBrushes( mx:Number, my:Number ):void
		{
			var instance:Sprite;
			
			var j:int;
			var i:int = numChildren;
			while ( --i > -1 )
			{
				instance = getChildAt( i ) as Sprite;
				j = instance.numChildren;
				while ( --j > -1 )
					( instance.getChildAt( j ) as IBrush ).release( mx, my );
			}
		}
		
		public function createInstance():void
		{
			var instance:Sprite = new Sprite();
			addChild( instance );
			
			var brush:IBrush;
			var n:int = _ribbonsDatas.length;
			for ( var i:int; i < n; ++i )
			{
				brush = _ribbonsDatas[ i ].copy();
				brush.addEventListener( PaintingEvent.BRUSH_COMPLETE, onBrushComplete, false, int.MAX_VALUE, true );
				instance.addChild( brush as Sprite );
				
				brush.create();
			}
		}
		
		public function deleteInstance( instance:Sprite ):void
		{
			var brush:IBrush;
			
			var i:int = instance.numChildren;
			while ( --i > -1 )
			{
				brush = instance.getChildAt( i ) as IBrush;
				brush.dispose();
				brush.removeEventListener( PaintingEvent.BRUSH_COMPLETE, onBrushComplete );
			}
			
			removeChild( instance );
		}
		
		public function getBrushIndex( brush:IBrush ):int
		{
			return _ribbonsDatas.indexOf( brush );
		}
		
		public function hasBrush( brush:IBrush ):Boolean
		{
			return _ribbonsDatas.indexOf( brush ) != -1;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}