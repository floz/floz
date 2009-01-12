
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.utils.UBit;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Background extends MovieClip 
	{
		private var bg:MovieClip;
		private var background:Bitmap;
		private var tempBitmap:Bitmap;
		
		private var pattern:BitmapData;
		
		public function Background() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			bg = new MovieClip();
			addChild( bg );
			
			var g:Graphics = bg.graphics;
			g.beginFill( Const.PUB_COLOR );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			
			ColorShortcuts.init();
			
			pattern = new Pattern2( 0, 0 );
			background = new Bitmap( getPatternAsBitmapData() );
			addChild( background );
			
			tempBitmap = new Bitmap();
			addChild( tempBitmap );
			
			stage.addEventListener( Event.RESIZE, onResize );
		}
		
		private function onResize(e:Event):void 
		{
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
			
			background.bitmapData.dispose();
			background.bitmapData = getPatternAsBitmapData();
			tempBitmap.bitmapData.dispose();
			tempBitmap.bitmapData = getPatternAsBitmapData();
		}
		
		// PRIVATE
		
		private function getPatternAsBitmapData():BitmapData
		{
			return UBit.strech( pattern, stage.stageWidth, stage.stageHeight );
		}
		
		// PUBLIC
		
		public function changeColor( color:uint ):void
		{
			switch( color )
			{
				case Const.PUB_COLOR: pattern = new Pattern2( 0, 0 ); break;
				case Const.SHORT_COLOR: pattern = new Pattern1( 0, 0 ); break;
				case Const.CLIP_COLOR: pattern = new Pattern3( 0, 0 ); break;
			}			
			
			var bmpd:BitmapData;
			bmpd = getPatternAsBitmapData(); 
			
			if ( tempBitmap.bitmapData )
			{
				background.bitmapData.dispose();
				background.bitmapData = tempBitmap.bitmapData.clone();
				background.alpha = 1;
				
				tempBitmap.bitmapData.dispose();
			}
			
			tempBitmap = new Bitmap( bmpd );
			tempBitmap.alpha = 0;
			addChild( tempBitmap );
			
			TweenLite.killTweensOf( tempBitmap );
			TweenLite.killTweensOf( background );
			TweenLite.to( tempBitmap, .5, { alpha: 1, ease: Quad.easeOut } );
			TweenLite.to( background, .5, { alpha: 0, ease: Quad.easeOut } );
		}
		
	}
	
}