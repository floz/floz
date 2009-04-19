
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.Tweener;
	import fl.motion.easing.Back;
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
		private var color:Array;
		
		private var bg:Sprite;
		private var currentBackground:Sprite;
		private var newBackground:Sprite;
		private var line:Sprite;		
		
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
			
			bg = new Sprite();
			addChild( bg );
			
			this.color = Const.PUB_COLOR;
			currentBackground = new Sprite();
			addChild( currentBackground );
			currentBackground.addChild( getNewBackground() );
			
			newBackground = new Sprite();
			addChild( newBackground );
			
			line = new Sprite();
			addChild( line );
			line.addChild( getLine() );
			
			stage.addEventListener( Event.RESIZE, onResize );
		}
		
		private function onResize(e:Event):void 
		{
			while ( line.numChildren ) line.removeChildAt( 0 );
			line.addChild( getLine() );
			
			while ( currentBackground.numChildren ) currentBackground.removeChildAt( 0 );
			currentBackground.addChild( getNewBackground() );
			
			while ( newBackground.numChildren ) newBackground.removeChildAt( 0 );
			newBackground.addChild( getNewBackground() );
		}
		
		// PRIVATE
		
		private function getNewBackground():Sprite
		{
			var sp:Sprite = new Sprite();
			
			var g:Graphics = sp.graphics;
			g.beginFill( color[ 1 ] );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			
			var s:Shape = new Shape();
			g = s.graphics;
			g.beginFill( color[ 0 ] );
			g.drawCircle( 0, 0, stage.stageHeight + ( stage.stageHeight * 110 / 100 ) * .5 );
			g.endFill();
			sp.addChild( s );
			
			return sp;
		}
		
		private function getLine():Shape
		{
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.lineStyle( 50, 0x000000 );
			g.beginFill( 0x000000, 0 );
			g.drawCircle( 0, 0, stage.stageHeight + ( stage.stageHeight * 110 / 100 ) * .5 );
			g.endFill();
			
			return s;
		}
		
		// PUBLIC
		
		public function changeColor( color:Array ):void
		{
			this.color = color;
			
			if ( newBackground.numChildren ) 
			{
				while ( currentBackground.numChildren ) currentBackground.removeChildAt( 0 );
				currentBackground.addChild( newBackground.getChildAt( 0 ) );
				currentBackground.alpha = 1;
				
				while ( newBackground.numChildren ) newBackground.removeChildAt( 0 );
			}
			
			newBackground.alpha = 0;
			newBackground.addChild( getNewBackground() );
			
			TweenLite.killTweensOf( currentBackground );
			TweenLite.killTweensOf( newBackground );
			TweenLite.to( currentBackground, .5, { alpha: 0, ease: Quad.easeOut } );
			TweenLite.to( newBackground, .5, { alpha: 1, ease: Quad.easeOut } );
		}
		
	}
	
}