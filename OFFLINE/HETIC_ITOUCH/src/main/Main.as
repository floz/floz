
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import fr.minuit4.effects.Loading;
	import fr.minuit4.tools.FPS;
	
	public class Main extends MovieClip
	{
		public static const READY:String = "ready";
		
		public var menu:Menu;
		public var container:MovieClip;
		
		private var _engine:Engine;
		private var _downloader:Downloader;
		private var _loading:Loading;
		private var _swfs:Array;
		private var _datas:Datas;
		
		public function Main() // bcbcbc ffffff
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			_engine = new Engine( 980, 560 );
			_engine.addEventListener( Engine.READY_TO_LOAD, onReadyToLoad );
			addChild( _engine );
			
			var _fps:FPS = new FPS();
			//addChild( _fps );
			
			_downloader = new Downloader();
			_downloader.addEventListener( Downloader.SWF_LOADED, onSWFLoaded );
			
			container.zClose.visible = false;
			container.zClose.alpha = 0;
			container.zClose.buttonMode = true;
			container.background.visible = false;
			
			var s:Sprite = new Sprite();
			var g:Graphics = s.graphics;
			g.beginFill( 0x00FF00 );
			g.drawRect( container.x, container.y, container.background.width, container.background.height );
			g.endFill();
			addChild( s );
			
			container.cnt.mask = s;
			
			container.zClose.addEventListener( MouseEvent.CLICK, onCloseClick );
			
			_loading = new Loading( 0x7a7a7a, 24, 10 );
			_loading.x = ( container.background.width >> 1 ) - ( _loading.width >> 1 );
			_loading.y = ( container.background.height >> 1 ) - ( _loading.height >> 1 );
			container.addChild( _loading );
			
			setChildIndex( container, numChildren - 1 );
			
			_swfs = [];
			
			_datas = new Datas( "xml/files.xml" );
			_datas.addEventListener( Event.COMPLETE, onComplete );
			_datas.load();
		}
		
		private function onReadyToLoad(e:Event):void 
		{
			_loading.play();
			
			var o:Object;
			
			var a:Array = _datas.getInfos();
			var i:int;
			var n:int = a.length;
			for ( i; i < n; i++ )
				if ( _engine.getTargetName() == a[ i ].name ) o = a[ i ];
				
			if ( o == null ) return;
			
			_downloader.add( { name: o.name, url: o.swf } );
			_downloader.load();
		}
		
		private function onSWFLoaded(e:Event):void 
		{
			_engine.hide();
			_engine.stopRendering();
			_loading.stop();
			
			container.zClose.visible = true;
			container.zClose.alpha = 1;
			container.background.visible = true;
			
			while ( container.cnt.numChildren ) container.cnt.removeChildAt( 0 );
			_swfs.push( _downloader.lastItemDownloaded );
			
			container.cnt.addChild( _downloader.lastItemDownloaded.content as MovieClip );
		}
		
		private function onCloseClick(e:MouseEvent):void 
		{
			removeSWF();
			
			_engine.setTarget( "Index" );
		}
		
		private function onComplete(e:Event):void 
		{
			dispatchEvent( new Event( Main.READY ) );
			_engine.init( _datas.getInfos() );
			
			menu.addEventListener( Menu.SELECTED, onSelected );
		}
		
		private function onSelected(e:Event):void 
		{
			if ( e.currentTarget.rubriqueName == _engine.getTargetName() ) return;
			
			if ( _loading.playing ) _loading.stop();
			removeSWF();
			
			_engine.setTarget( e.currentTarget.rubriqueName );
		}
		
		// PRIVATE
		
		private function removeSWF():void
		{
			if ( !container.cnt.numChildren ) return;
			
			while ( container.cnt.numChildren ) container.cnt.removeChildAt( 0 );
			
			container.zClose.visible = false;
			container.zClose.alpha = 0;
			container.background.visible = false;
			
			_engine.startRendering();
			_engine.show();
		}
		
		// PUBLIC
		
	}
	
}