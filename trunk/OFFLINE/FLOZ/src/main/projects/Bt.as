
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.projects 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import gs.easing.Cubic;
	import gs.easing.Quad;
	import gs.TweenLite;
	import main.Config;
	
	public class Bt extends MovieClip
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		public static const PREV:String = "bt_left";
		public static const NEXT:String = "bt_right";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _textValue:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var strk:Sprite;
		public var cntContent:MovieClip;
		public var z:SimpleButton;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Bt() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			TweenLite.killTweensOf( cntContent );
			
			z.removeEventListener( MouseEvent.MOUSE_OVER, onOver) ;
			z.removeEventListener( MouseEvent.MOUSE_OUT, onOut) ;
			z.removeEventListener( MouseEvent.CLICK, onClick) ;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_textValue = cntContent.txt1.text;
			
			cntContent.txt1.styleSheet =
			cntContent.txt2.styleSheet = Config.styleSheet;
			cntContent.txt1.htmlText = 
			cntContent.txt2.htmlText = "<span class='buttons'>" + _textValue + "</span>";
			
			var glowFilter:GlowFilter = Config.glowFilter.clone() as GlowFilter;
			glowFilter.strength = 2.2;
			cntContent.filters =
			strk.filters = [ glowFilter ];
			
			z.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			z.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			z.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			TweenLite.to( cntContent, .2, { y: -strk.height + 11, ease: Cubic.easeOut } );		
		}
		
		private function onOut(e:MouseEvent):void 
		{
			TweenLite.to( cntContent, .2, { y: 11, ease: Cubic.easeOut } );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			dispatchEvent( new Event( _textValue == "PREV" ? Bt.PREV : Bt.NEXT ) ); 
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}