﻿
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import fr.minuit4.effects.ApparitionTextEffect;
	import fr.minuit4.effects.DisparitionTextEffect;
	import fr.minuit4.tools.loaders.types.TextLoader;
	import fr.minuit4.tools.Loading;
	
	public class Main extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loading:Loading;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_loading = new Loading( 0x00 );
			_loading.x = stage.stageWidth * .5 - _loading.width * .5;
			_loading.y = stage.stageHeight * .5 - _loading.height * .5;
			_loading.play();
			addChild( _loading );
			
			var xmlLoader:TextLoader = new TextLoader();
			xmlLoader.addEventListener( Event.COMPLETE, onComplete );
			xmlLoader.load( path_xml + "datas.xml" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onComplete(e:Event):void 
		{
			var _xml:XML = XML( TextLoader( e.currentTarget ).getItemLoaded() );
			TextLoader( e.currentTarget ).destroy();
			
			trace( _xml );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_xml():String { return loaderInfo.parameters[ "path_xml" ] || "xml/"; }		
	}
	
}