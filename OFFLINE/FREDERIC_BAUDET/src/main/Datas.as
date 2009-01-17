
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Datas extends EventDispatcher
	{
		private var request:URLRequest;
		private var loader:URLLoader;
		
		private var xml:XML;
		
		public function Datas( url:String ) 
		{
			request = new URLRequest( url );
			loader = new URLLoader();
			loader.addEventListener( Event.COMPLETE, onComplete );
			loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// EVENTS
		
		private function onComplete(e:Event):void 
		{
			xml = XML( e.currentTarget.data );
			
			dispatchEvent( new Event( Event.COMPLETE ) );
			
			loader.removeEventListener( Event.COMPLETE, onComplete );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "Datas.onIOError : " + request.url );			
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function load():void
		{
			loader.load( request );
		}
		
		public function getInfos( rubrique:String ):Array
		{
			var a:Array = [];
			
			var x:XML;
			for each( x in xml[ rubrique ].vignette ) a.push( { img: xml.path.@img + rubrique + "/" + x.@img, flv: xml.path.@flv + rubrique + "/" + x.@flv, title: x.@title, director: x.@director, sound: x.@sound } );
			
			return a
		}
		
		public function getLinks():Array
		{
			var tab:Array = [];
			var a:Array = [];
			
			var x:XML;
			for each( x in xml[ "links" ][ "directors" ].link ) a.push( { url: x.@url, mail: x.@mail } );
			tab.push( a );
			a = [];
			for each( x in xml[ "links" ][ "production" ].link ) a.push( { url: x.@url, mail: x.@mail } );
			tab.push( a );
			a = [];			
			for each( x in xml[ "links" ][ "postproduction" ].link ) a.push( { url: x.@url, mail: x.@mail } );
			tab.push( a );
			a = [];
			for each( x in xml[ "links" ][ "storyboarder" ].link ) a.push( { url: x.@url, mail: x.@mail } );
			tab.push( a );
			a = [];
			for each( x in xml[ "links" ][ "sound" ].link ) a.push( { url: x.@url, mail: x.@mail } );
			tab.push( a );
			a = [];
			
			return tab
		}
		
	}
	
}