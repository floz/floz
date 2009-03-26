
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.tools.loaders.types.ImageLoader;
	import fr.minuit4.tools.loaders.types.TextLoader;
	import fr.minuit4.tools.Loading;
	
	public class Main extends MovieClip
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loading:Loading;
		private var _xmlLoader:TextLoader;
		
		private var _datas:XML;
		private var _imageLoader:ImageLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var mapHolder:MapHolder;
		public var panelLists:PanelLists;
		public var panelInfos:PanelInfos;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_loading = new Loading( 0x000000 );
			_loading.x = stage.stageWidth * .5 - _loading.width * .5;
			_loading.y = stage.stageHeight * .5 - _loading.height * .5;
			addChild( _loading );
			_loading.play();
			
			_xmlLoader = new TextLoader();
			_xmlLoader.addEventListener( Event.COMPLETE, onXMLComplete );
			_xmlLoader.load( path_xml + saison + ".xml" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onXMLComplete(e:Event):void 
		{
			_datas = XML( _xmlLoader.getItemLoaded() );
			_xmlLoader.destroy();
			_xmlLoader = null;
			
			Model.datas = parseXML();
			
			_imageLoader = new ImageLoader();
			_imageLoader.addEventListener( Event.COMPLETE, onImageComplete );
			_imageLoader.load( path_plans + saison + ".jpg" );
		}
		
		private function onImageComplete(e:Event):void 
		{
			Model.map = Bitmap( _imageLoader.getItemLoaded() ).bitmapData.clone();
			_imageLoader.destroy();
			_imageLoader = null;
			
			init();
		}
		
		private function onItemSelect(e:Event):void 
		{
			mapHolder.zoom();
			panelInfos.displayInfos();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function parseXML():Array
		{
			var x:XML;
			
			var infos:Array = [];
			var a:Array;
			var i:int;
			var n:int;
			var listIndex:int;
			for each( x in _datas.list )
			{
				a = [];
				n = x.item.length();
				for ( i = 0; i < n; ++i )
				{
					a.push( { 
						label: x.item.@name[ i ], 
						listIndex: listIndex,
						coordX: x.item.@coordX[ i ], 
						coordY: x.item.@coordY[ i ], 
						img: x.item.@img[ i ], 
						titre: x.item.@titre[ i ], 
						infoText: x.item.@infoText[ i ], 
						text: x.item.@text[ i ] 
						} );
				}
				infos.push( { id: x.@id, datas: a } );
				listIndex++;
			}			
			a = null;
			
			return infos;
		}
		
		private function init():void
		{
			_loading.stop();
			removeChild( _loading );
			_loading = null;
			
			panelLists.addEventListener( PanelLists.ITEM_SELECT, onItemSelect );
			panelLists.activate();
			
			panelInfos.activate();
			
			mapHolder.activate();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_xml():String { return loaderInfo.parameters[ "path_xml" ] || "assets/xml/"; }
		public function get path_plans():String { return loaderInfo.parameters[ "path_plans" ] || "assets/img/plans/"; }
		public function get path_photos():String { return loaderInfo.parameters[ "path_photos" ] || "assets/img/photos/"; }
		public function get saison():String { return loaderInfo.parameters[ "saison" ] || "ete"; }
		
	}
	
}