
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes.ribbons.type 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import painting.events.PaintingEvent;
	import painting.interfaces.IBrush;
	import painting.interfaces.IBrushCtrl;
	import painting.interfaces.IBrushHolder;
	
	public class RibbonsHolder extends Sprite implements IBrushHolder
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _brushComplete:PaintingEvent;
		
		private var _painting:Boolean;
		private var _active:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function RibbonsHolder() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			_painting = true;
			_active = true;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_brushComplete = new PaintingEvent( PaintingEvent.BRUSH_COMPLETE, true );
			_brushComplete.brushHolder = this;
			_brushComplete.brushCtrl = this.parent as IBrushCtrl;
		}
		
		private function onBrushComplete(e:PaintingEvent):void 
		{
			_active = false;
			
			var i:int = numChildren;
			while ( --i > -1 )
				getChildAt( i ).removeEventListener( PaintingEvent.BRUSH_COMPLETE, onBrushComplete );
			
			var drawEvent:PaintingEvent = new PaintingEvent( PaintingEvent.DRAW, true );
			drawEvent.brushHolder = this;
			drawEvent.brushCtrl = this.parent as IBrushCtrl;
			dispatchEvent( drawEvent );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update( mx:Number, my:Number ):int
		{
			if ( !numChildren || !_active )
				return 0;
			
			var count:int;
			
			var ribbon:IBrush;
			
			var i:int = numChildren;			
			if ( _painting )
			{
				while ( --i > -1 )
				{
					ribbon = getChildAt( i ) as IBrush;
					ribbon.paint( mx, my );
				}
				++count;
			}
			else
			{
				while ( --i > -1 )
				{
					ribbon = getChildAt( i ) as IBrush;
					count += ribbon.completePainting();
				}
			}
			
			return count;
		}
		
		public function addBrush( brush:IBrush ):void
		{
			var ribbon:Ribbon = brush.copy() as Ribbon;
			ribbon.addEventListener( PaintingEvent.BRUSH_COMPLETE, onBrushComplete );
			addChild( ribbon );
			
			ribbon.create();
		}
		
		public function releaseBrushes( mx:Number, my:Number ):void
		{
			if ( !_painting ) return;
			
			var i:int = numChildren;
			while ( --i > -1 )
				( getChildAt( i ) as IBrush ).release( mx, my );
			
			_painting = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}