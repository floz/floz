﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.details 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.net.loaders.types.MassLoader;
	import fr.minuit4.tools.diaporama.Diaporama;
	import fr.minuit4.tools.diaporama.types.SlidingDiaporama;
	import gs.easing.Cubic;
	import gs.easing.Quad;
	import gs.TweenLite;
	import main.Config;
	
	public class DetailsDiaporama extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _project:Object;
		private var _diaporama:SlidingDiaporama;
		
		private var _massLoader:MassLoader;
		
		private var _ready:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:Sprite;
		public var strk:Sprite;
		public var panel:Panel;
		public var shadow:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DetailsDiaporama() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			panel.removeEventListener( Panel.FIRST, onFirst );
			panel.removeEventListener( Panel.PREV, onPrev );
			panel.removeEventListener( Panel.NEXT, onNext );
			panel.removeEventListener( Panel.LAST, onLast );
			panel.removeEventListener( Panel.PLAYSLIDESHOW, onPlaySlideShow );
			panel.removeEventListener( Panel.INDEX_CLICK, onIndexClick );
			
			stopDiaporamaMode();
			_diaporama.clearImages();
			_diaporama.removeEventListener( Diaporama.SWITCH_COMPLETE, onSwitchComplete );
			_diaporama = null;
			
			_massLoader.removeEventListener( Event.COMPLETE, onLoadComplete );
			_massLoader.destroy();
			
			TweenLite.killTweensOf( shadow );
			TweenLite.killTweensOf( panel );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			panel.addEventListener( Panel.FIRST, onFirst );
			panel.addEventListener( Panel.PREV, onPrev );
			panel.addEventListener( Panel.NEXT, onNext );
			panel.addEventListener( Panel.LAST, onLast );
			panel.addEventListener( Panel.PLAYSLIDESHOW, onPlaySlideShow );
			panel.addEventListener( Panel.INDEX_CLICK, onIndexClick );
			
			panel.y = 359 - 40;
			
			strk.filters = [ Config.glowFilter ];
		}
		
		private function onFirst(e:Event):void 
		{
			if ( !_ready ) return;
			
			stopDiaporamaMode()
			_diaporama.to( 0 );
			panel.setIndexState( _diaporama.currentId );
		}
		
		private function onPrev(e:Event):void 
		{
			if ( !_ready ) return;
			
			stopDiaporamaMode()
			_diaporama.previous();
			panel.setIndexState( _diaporama.currentId );
		}
		
		private function onNext(e:Event):void 
		{
			if ( !_ready ) return;
			
			stopDiaporamaMode()
			_diaporama.next();
			panel.setIndexState( _diaporama.currentId );
		}
		
		private function onLast(e:Event):void 
		{
			if ( !_ready ) return;
			
			stopDiaporamaMode()
			_diaporama.to( _diaporama.totalCount );
			panel.setIndexState( _diaporama.currentId );
		}
		
		private function onPlaySlideShow(e:Event):void 
		{
			if ( !_ready ) return;
			
			if ( _diaporama.isPlaying() )
				_diaporama.stopDiaporamaMode();
			else
				_diaporama.startDiaporamaMode( 4000 );
			
			switchBtSlideShowState();
		}
		
		private function onIndexClick(e:Event):void 
		{
			if ( !_ready ) return;
			
			stopDiaporamaMode()
			_diaporama.to( panel.indexSelect );
		}
		
		private function onLoadComplete(e:Event):void 
		{
			if( _massLoader.hasNext() )
				_massLoader.loadNext();
			else
			{
				_ready = true;
				
				_diaporama.stopDiaporamaMode();
				_diaporama.clearImages();
				_diaporama.addImages( _massLoader.getItemsLoaded() );
				_diaporama.startDiaporamaMode( 4000 );
				
				panel.addIndex( _diaporama.totalCount );
				panel.setIndexState( _diaporama.currentId );
				
				switchBtSlideShowState();
				
				TweenLite.to( shadow, .3, { alpha: 0, ease: Cubic.easeOut } );
			}
		}
		
		private function onSwitchComplete(e:Event):void 
		{
			panel.setIndexState( _diaporama.currentId );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function switchBtSlideShowState():void
		{
			if ( _diaporama.isPlaying() )
				panel.setBtSlideShowOnStop();
			else
				panel.setBtSlideShowOnPlay();
		}
		
		private function stopDiaporamaMode():void
		{
			if ( _diaporama.isPlaying() ) 
			{
				_diaporama.stopDiaporamaMode();
				switchBtSlideShowState();
			}
		}
		
		private function destroy():void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkToProject( project:Object ):void
		{
			this._project = project;
			
			TweenLite.to( shadow, .3, { alpha: 1, ease: Cubic.easeOut } );
			
			panel.resetIndex();
			
			if ( !_diaporama )
			{
				_diaporama = new SlidingDiaporama( strk.width, strk.height, 0x000000, .4 );
				_diaporama.addEventListener( Diaporama.SWITCH_COMPLETE, onSwitchComplete );
				cnt.addChild( _diaporama );
			}
			
			var path_img:String = project.section.toLowerCase() == Config.WORKS.toLowerCase() ? Config.path_works : Config.path_lab
			var a:Array = [];
			var n:int = project.diaporama.length;
			for ( var i:int; i < n; ++i )
				a.push( Config.path_img + path_img + project.diaporama[ i ] );
			
			if ( _massLoader )
			{
				_massLoader.clean( true );
				_massLoader.destroy();
				_massLoader.removeEventListener( Event.COMPLETE, onLoadComplete );
				_massLoader = null;
			}
			_massLoader = new MassLoader();
			_massLoader.addEventListener( Event.COMPLETE, onLoadComplete );			
			_massLoader.addItems( a );
			_massLoader.loadNext();
		}
		
		public function showPanel():void
		{
			TweenLite.to( panel, .3, { y: 359, ease: Quad.easeOut } );
		}
		
		public function hidePanel():void
		{
			TweenLite.to( panel, .3, { y: int( 359 - 40 ), ease: Quad.easeOut, onComplete: destroy } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}