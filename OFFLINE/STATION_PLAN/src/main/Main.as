﻿
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
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Security;
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
		
		private var _toolTip:ToolTip;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var mapHolder:MapHolder;
		public var panelLists:PanelLists;
		public var panelInfos:PanelInfos;
		public var zMoins:SimpleButton;
		public var zPlus:SimpleButton;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			Security.allowDomain( "*" );
			Security.allowInsecureDomain( "*" );
			
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
			
			zMoins.addEventListener( MouseEvent.CLICK, onClick );
			zPlus.addEventListener( MouseEvent.CLICK, onClick );
			
			init();
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case zMoins: mapHolder.hide(); break;
				case zPlus: mapHolder.centerZoom(); break;
			}
		}
		
		private function onItemSelect(e:Event):void 
		{
			mapHolder.zoom();
			panelInfos.displayInfos();
		}
		
		private function onShow(e:Event):void 
		{
			_toolTip.show( Puce( e.target ) );
		}
		
		private function onHide(e:Event):void 
		{
			_toolTip.hide();
		}
		
		private function onMapZoomHide(e:Event):void 
		{
			panelInfos.reset();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function parseXML():Array
		{
			Model.delay = _datas.infos.@wait * 1000;
			
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
						imgUrl: x.item.@img[ i ], 
						img: null,
						title: x.item.@titre[ i ], 
						infoText: x.item.@infoText[ i ], 
						text: x.item.@text[ i ],
						url: x.item.@url[ i ],
						id: x.item.@id[ i ]
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
			Model.path_photos = path_photos;
			
			_loading.stop();
			removeChild( _loading );
			_loading = null;
			
			panelLists.addEventListener( PanelLists.ITEM_SELECT, onItemSelect );
			panelLists.activate();
			
			panelInfos.activate();
			
			mapHolder.activate();
			mapHolder.addEventListener( Puce.TOOLTIP_SHOW, onShow );
			mapHolder.addEventListener( Puce.TOOLTIP_HIDE, onHide );
			mapHolder.addEventListener( MapZoomHolder.HIDE, onMapZoomHide );
			
			_toolTip = new ToolTip();
			addChild( _toolTip );
			
			gotoSelectedIndex();
		}
		
		private function gotoSelectedIndex():void
		{
			if ( !int( id ) ) return;
			var i:int = int( id );
			
			var a:Array = getItemIdsById( i );
			if ( a[ 0 ] < 0 || a[ 0 ] >= Model.datas.length ) return;
			if ( a[ 1 ]	<= 0 || a[ i ] > Model.datas[ a[ 0 ] ].datas.length ) return;
			
			panelLists.selectItem( a[ 0 ], a[ 1 ] );
		}
		
		private function getItemIdsById( id:int ):Array
		{
			var j:int;
			var n:int = Model.datas.length;
			var m:int;
			for ( var i:int; i < n; ++i )
			{
				m = Model.datas[ i ].datas.length;
				for ( j = 0; j < m; ++j )
					if ( Model.datas[ i ].datas[ j ].id == id ) return [ i, int( j+1 ) ];
			}
			return null;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_xml():String { return loaderInfo.parameters[ "path_xml" ] || "assets/xml/"; }
		public function get path_plans():String { return loaderInfo.parameters[ "path_plans" ] || "assets/img/plans/"; }
		public function get path_photos():String { return loaderInfo.parameters[ "path_photos" ] || "assets/img/photos/"; }
		public function get saison():String { return loaderInfo.parameters[ "saison" ] || "ete"; }
		public function get id():String { return loaderInfo.parameters[ "id" ] || "35"; }
	}
	
}