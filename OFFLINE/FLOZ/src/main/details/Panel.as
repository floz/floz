
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.details 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import gs.easing.Cubic;
	import gs.easing.Quad;
	import gs.TweenLite;
	import main.Config;
	
	public class Panel extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		public static const FIRST:String = "panel_first";
		public static const PREV:String = "panel_prev";
		public static const NEXT:String = "panel_next";
		public static const LAST:String = "panel_last";
		public static const PLAYSLIDESHOW:String = "panel_playslideshow";
		public static const INDEX_CLICK:String = "panel_index_click";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _firstEvent:Event;
		private var _prevEvent:Event;
		private var _nextEvent:Event;
		private var _lastEvent:Event;
		private var _playSlideShowEvent:Event;
		
		private var _indexOver:int;
		private var _indexOut:int;
		private var _indexSelect:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var btFirst:SimpleButton;
		public var btPrev:SimpleButton;
		public var btNext:SimpleButton;
		public var btLast:SimpleButton;
		public var btSlideshow:SimpleButton;
		public var first:MovieClip;
		public var prev:MovieClip;
		public var next:MovieClip;
		public var last:MovieClip;
		public var slideshow:MovieClip;
		public var strk1:Sprite;
		public var strk2:Sprite;
		public var cnt:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Panel() 
		{
			_firstEvent = new Event( Panel.FIRST );
			_prevEvent = new Event( Panel.PREV );
			_nextEvent = new Event( Panel.NEXT );
			_lastEvent = new Event( Panel.LAST );
			_playSlideShowEvent = new Event( Panel.PLAYSLIDESHOW );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			a = [ btFirst, btPrev, btNext, btLast, btSlideshow ];
			i = a.length;
			while ( --i > -1 )
			{
				a[ i ].removeEventListener( MouseEvent.MOUSE_OVER, onOver );
				a[ i ].removeEventListener( MouseEvent.MOUSE_OUT, onOut );
				a[ i ].removeEventListener( MouseEvent.CLICK, onClick );
			}
			
			TweenLite.killTweensOf( cnt )
			
			var a:Array = [ first, prev, next, last, slideshow ];
			var i:int = a.length;
			while ( --i > -1 )
				TweenLite.killTweensOf( a[ i ] );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			var filter:GlowFilter = Config.glowFilter.clone() as GlowFilter;
			filter.strength = 3;
			
			var textValue:String;
			var a:Array = [ first, prev, next, last, slideshow ];
			var i:int = a.length;
			while ( --i > -1 )
			{
				textValue = a[ i ].txt1.text;
				
				a[ i ].txt1.embedFonts =
				a[ i ].txt2.embedFonts = true;
				
				a[ i ].txt1.styleSheet =
				a[ i ].txt2.styleSheet = Config.styleSheet;
				
				a[ i ].txt1.htmlText =
				a[ i ].txt2.htmlText = "<span class='buttons'>" + textValue + "</span>";
				
				a[ i ].filters = [ filter ];
			}
			
			cnt.filters = [ filter ];
			
			a = [ btFirst, btPrev, btNext, btLast, btSlideshow ];
			i = a.length;
			while ( --i > -1 )
			{
				a[ i ].addEventListener( MouseEvent.MOUSE_OVER, onOver );
				a[ i ].addEventListener( MouseEvent.MOUSE_OUT, onOut );
				a[ i ].addEventListener( MouseEvent.CLICK, onClick );
			}
			
			strk1.filters =
			strk2.filters = [ Config.glowFilter ];
			
			_indexSelect = -1;
			
			a = null;
		}
		
		private function onOver(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case btFirst: rollOver( first ); break;
				case btPrev: rollOver( prev ); break;
				case btNext: rollOver( next ); break;
				case btLast: rollOver( last ); break;
				case btSlideshow: rollOver( slideshow ); break;
			}
		}
		
		private function onOut(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case btFirst: rollOut( first ); break;
				case btPrev: rollOut( prev ); break;
				case btNext: rollOut( next ); break;
				case btLast: rollOut( last ); break;
				case btSlideshow: rollOut( slideshow ); break;
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case btFirst: dispatchEvent( _firstEvent ); break;
				case btPrev: dispatchEvent( _prevEvent ); break;
				case btNext: dispatchEvent( _nextEvent ); break;
				case btLast: dispatchEvent( _lastEvent ); break;
				case btSlideshow: dispatchEvent( _playSlideShowEvent ); break;
			}
		}
		
		private function onIndexOver(e:MouseEvent):void 
		{
			_indexOver = cnt.getChildIndex( e.currentTarget as DisplayObject );
			if ( _indexOver == _indexSelect ) return;
			
			var index:Index = e.currentTarget as Index;
			index.txt.htmlText = "<span class='index_over'>" + index.txt.text + "</span>";
		}
		
		private function onIndexOut(e:MouseEvent):void 
		{
			_indexOut = cnt.getChildIndex( e.currentTarget as DisplayObject );
			if ( _indexOut == _indexSelect ) return;
			
			var index:Index = e.currentTarget as Index;
			index.txt.htmlText = "<span class='index'>" + index.txt.text + "</span>";
		}
		
		private function onIndexClick(e:MouseEvent):void 
		{
			if ( cnt.getChildIndex( e.currentTarget as DisplayObject ) == _indexSelect ) return;
			
			var index:Index;			
			if ( _indexSelect >= 0 )
			{
				index = cnt.getChildAt( _indexSelect ) as Index;
				index.txt.htmlText = "<span class='index'>" + index.txt.text + "</span>";
			}
			_indexSelect =  cnt.getChildIndex( e.currentTarget as DisplayObject );
			
			index = e.currentTarget as Index;
			index.txt.htmlText = "<span class='index_selected'>" + index.txt.text + "</span>";
			
			dispatchEvent( new Event( Panel.INDEX_CLICK ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function refreshSlideShow( textValue:String ):void
		{
			slideshow.txt1.styleSheet =
			slideshow.txt2.styleSheet = Config.styleSheet;
			
			slideshow.txt1.htmlText =
			slideshow.txt2.htmlText = "<span class='buttons'>" + textValue + "</span>";
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function rollOver( target:MovieClip ):void
		{
			TweenLite.to( target, .2, { y: - strk1.height + 9, ease: Cubic.easeOut } );
		}
		
		public function rollOut( target:MovieClip ):void
		{
			TweenLite.to( target, .2, { y: 9, ease: Cubic.easeOut } );
		}
		
		public function setBtSlideShowOnPlay():void
		{
			refreshSlideShow( "PLAY SLIDESHOW" );
		}
		
		public function setBtSlideShowOnStop():void
		{
			refreshSlideShow( "STOP SLIDESHOW" );
		}
		
		public function addIndex( count:int ):void
		{
			cnt.alpha = 0;
			
			const space:Number = 18;
			const middle:Number = 98 >> 1;
			const tempWidth:Number = count * space;
			var beginX:Number = middle - ( tempWidth >> 1 );
			
			var i:int;
			var index:Index;
			for (; i < count; ++i )
			{
				index = new Index();
				index.txt.embedFonts = true;
				index.txt.styleSheet = Config.styleSheet;
				index.txt.htmlText = "<span class='index'>" + int( i + 1 ).toString() + "</span>";
				index.x = beginX;
				index.addEventListener( MouseEvent.MOUSE_OVER, onIndexOver );
				index.addEventListener( MouseEvent.MOUSE_OUT, onIndexOut );
				index.addEventListener( MouseEvent.CLICK, onIndexClick );
				beginX += space;
				cnt.addChild( index );
			}
			
			TweenLite.to( cnt, .3, { alpha: 1, ease: Quad.easeOut } );
		}
		
		public function setIndexState( indexToSelect:int ):void
		{
			var index:Index;			
			if ( _indexSelect >= 0 )
			{
				index = cnt.getChildAt( _indexSelect ) as Index;
				index.txt.htmlText = "<span class='index'>" + index.txt.text + "</span>";
			}
			_indexSelect = indexToSelect;
			
			index = cnt.getChildAt( indexToSelect ) as Index;
			index.txt.htmlText = "<span class='index_selected'>" + index.txt.text + "</span>";
		}
		
		public function resetIndex():void
		{
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get indexSelect():int { return _indexSelect; }
		
	}
	
}