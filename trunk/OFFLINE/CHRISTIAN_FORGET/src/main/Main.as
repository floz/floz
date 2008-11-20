
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		public static const READY:String = "ready";
		
		public static const WORKS:String = "works";
		public static const ARCHIVES:String = "works";
		public static const CONTACT:String = "contact";
		
		public var section:String = WORKS;
		
		public var screen:Screen;
		public var listeVignettes:ListeVignettes;
		
		private var datas:Datas;
		
		public var works:Array; // [ { name, preview, film }, { name, preview, film }, ... } ]
		public var archives:Array; // [ { name, preview, film }, { name, preview, film }, ... } ]
		public var contact:Object; // { mail, skype, tel }
		
		public function Main() 
		{
			datas = new Datas( "xml/projets.xml" );
			datas.load();
			
			datas.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete(e:Event):void 
		{			
			this.works = datas.getInfos( WORKS );
			this.archives = datas.getInfos( ARCHIVES );
			this.contact = datas.getContactInfos();
			
			dispatchEvent( new Event( Main.READY ) );
			
			listeVignettes.addEventListener( Vignette.VIGNETTE_OVER, onVignetteOver );
			listeVignettes.addEventListener( Vignette.VIGNETTE_OUT, onVignetteOut );
			listeVignettes.addEventListener( Vignette.VIGNETTE_PRESS, onVignettePress );
		}
		
		// EVENTS
		
		private function onVignetteOver(e:Event):void 
		{
			screen.display( getPathImages() + e.target.preview );
		}
		
		private function onVignetteOut(e:Event):void 
		{
			screen.clear();
		}
		
		private function onVignettePress(e:Event):void 
		{
			screen.select( getPathFLV() + e.target.film );		
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function getPathImages():String { return "images/" };
		
		public function getPathFLV():String { return "flv/" };
		
	}
	
}