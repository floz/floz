
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class MasksPanel extends MovieClip
	{
		// - CONST -----------------------------------------------------------------------
		
		public static const MASK_SELECTED:String = "mask_selected";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _px:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:MovieClip;
		public var bg:MovieClip;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MasksPanel() 
		{
			_px = this.x;			
			this.x = 250;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			//initBeatlesHolders();
		}
		
		private function onOver(e:MouseEvent):void 
		{
			MovieClip( e.currentTarget ).gotoAndPlay( "over" );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			MovieClip( e.currentTarget ).gotoAndPlay( "out" );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			Model.maskIdx = BeatlesHolder( e.currentTarget ).index;
			dispatchEvent( new Event( MasksPanel.MASK_SELECTED ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		public function initBeatlesHolders():void
		{
			var bh:BeatlesHolder;
			var n:int = Model.MASKS.length;
			for ( var i:int; i < n; ++i )
			{
				bh = new BeatlesHolder( i );
				bh.setMask( Model.MASKS[ i ] );
				bh.y = i * 100 + 10 * i;
				bh.addEventListener( MouseEvent.MOUSE_OVER, onOver );
				bh.addEventListener( MouseEvent.MOUSE_OUT, onOut );
				bh.addEventListener( MouseEvent.CLICK, onClick );
				cnt.addChild( bh );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function init():void
		{
			TweenLite.to( this, .4, { x: _px, ease: Quad.easeOut } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}