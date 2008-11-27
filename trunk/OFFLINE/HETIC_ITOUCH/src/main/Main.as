
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
	import flash.display.Shape;
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
		public var logo:MovieClip;
		
		private var _engine:Engine;
		private var _downloader:Downloader;
		private var _loading:Loading;
		private var _swfs:Array;
		private var _datas:Datas;
		private var _mask:Sprite;
		
		private var _anim:Sprite;
		private var _count:int;
		
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
			_engine.addEventListener( Engine.MOVING, onMoving );
			_engine.addEventListener( Engine.ENABLE, onEnable );
			addChild( _engine );
			
			setChildIndex( _engine, getChildIndex( menu ) );			
			
			var _fps:FPS = new FPS();
			//addChild( _fps );
			
			_downloader = new Downloader();
			_downloader.addEventListener( Downloader.SWF_LOADED, onSWFLoaded );
			
			container.zClose.visible = false;
			container.zClose.alpha = 0;
			container.zClose.buttonMode = true;
			container.background.visible = false;
			
			_mask = new Sprite();
			var g:Graphics = _mask.graphics;
			g.beginFill( 0x00FF00 );
			g.drawRect( container.x, container.y, container.background.width, container.background.height );
			g.endFill();			
			addChild( _mask );
			
			container.cnt.mask = _mask;
			
			container.zClose.addEventListener( MouseEvent.CLICK, onCloseClick );
			
			_loading = new Loading( 0x7a7a7a, 24, 10 );
			_loading.x = ( container.background.width >> 1 ) - ( _loading.width >> 1 );
			_loading.y = ( container.background.height >> 1 ) - ( _loading.height >> 1 );
			container.addChild( _loading );
			
			setChildIndex( container, numChildren - 1 );
			
			menu.enabled = false;
			
			_swfs = [];
			
			_datas = new Datas( "xml/files.xml" );
			_datas.addEventListener( Event.COMPLETE, onComplete );
			_datas.load();
		}
		
		private function onReadyToLoad(e:Event):void 
		{
			menu.rubriqueName = _engine.getTargetName();
			
			_loading.play();
			
			var o:Object;
			
			var a:Array = _datas.getInfos();
			var i:int;
			var n:int = a.length;
			for ( i; i < n; i++ )
				if ( _engine.getTargetName() == a[ i ].name ) o = a[ i ];
				
			if ( o == null ) return;
			
			//var index:int = -1;			
			//n = _swfs.length;
			//for ( i = 0; i < n; i++ )
				//if ( _swfs[ i ].name == o.name ) index = i;
			//
			//if ( index >= 0 ) 
			//{
				//display( _swfs[ index ].content as MovieClip );
				//return;
			//}
			
			_downloader.add( { name: o.name, url: o.swf } );
			_downloader.load();
		}
		
		private function onMoving(e:Event):void 
		{
			Tweener.addTween( logo, { alpha: 0, time: .30, transition: "easeInOutQuad" } );
		}
		
		private function onSWFLoaded(e:Event):void 
		{
			if ( _downloader.lastItemDownloaded.name != menu.rubriqueName ) return;
			
			_swfs.push( _downloader.lastItemDownloaded );
			
			display( _downloader.lastItemDownloaded.content as MovieClip );
		}
		
		private function onEnable(e:Event):void 
		{
			menu.enabled = true;
		}
		
		private function onCloseClick(e:MouseEvent):void 
		{
			removeSWF();
			
			_engine.setTarget( "Index" );
		}
		
		private function onComplete(e:Event):void 
		{
			dispatchEvent( new Event( Main.READY ) );
			intro();
			
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
		
		private function intro():void
		{
			var b:SlideBlur;
			_anim = new Sprite();
			addChild( _anim );
			for ( var i:int; i < 4; i++ )
			{
				b = new SlideBlur();
				b.y = logo.y - 87;
				b.x = logo.x + (logo.width >> 1) - (b.width >> 1);
				_anim.addChild( b );
				
				Tweener.addTween( b, { y: -500, time: .35, delay: i * .1, transition: "easeInOutQuad", onComplete: deleteIntro } );
			}
		}
		
		private function deleteIntro():void
		{
			_count++
			if ( _count < 4 ) return;
			
			removeChild( _anim );
			_anim = null;
			
			_engine.init( _datas.getInfos(), true );
		}
		
		private function removeSWF():void
		{
			if ( !container.cnt.numChildren ) return;
			
			while ( container.cnt.numChildren ) container.cnt.removeChildAt( 0 );
			
			container.zClose.visible = false;
			container.zClose.alpha = 0;
			container.background.visible = false;
			
			Tweener.addTween( logo, { alpha: 1, time: .30, delay: .20, transition: "easeInOutQuad" } );
			
			_engine.startRendering();
			_engine.show();
		}
		
		private function display( mc:MovieClip ):void
		{
			_engine.hide();
			_engine.stopRendering();
			_loading.stop();
			
			container.zClose.visible = true;
			container.zClose.alpha = 1;
			container.background.visible = true;
			
			while ( container.cnt.numChildren ) container.cnt.removeChildAt( 0 );
			container.cnt.addChild( mc );
		}
		
		// PUBLIC
		
	}
	
}