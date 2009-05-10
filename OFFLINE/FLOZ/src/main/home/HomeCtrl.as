﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.home 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import gs.TweenLite;
	import main.Config;
	
	public class HomeCtrl
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dispatcher:EventDispatcher;
		
		private var _cntProjects:Sprite;
		
		private var _killing:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function HomeCtrl()
		{
			_dispatcher = new EventDispatcher();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onLastProjectOver(e:Event):void 
		{
			var i:int = Config.cntMain.numChildren;
			var lpc:LastProjectContainer;
			while ( --i > -1 )
			{
				lpc = Config.cntMain.getChildAt( i ) as LastProjectContainer;
				if ( lpc == e.currentTarget ) lpc.lastProject.hideBorders()
				else lpc.lastProject.darken();
			}
		}
		
		private function onLastProjectOut(e:Event):void 
		{
			var i:int = Config.cntMain.numChildren;
			var lpc:LastProjectContainer;
			while ( --i > -1 )
			{
				lpc = Config.cntMain.getChildAt( i ) as LastProjectContainer;
				if ( lpc == e.currentTarget ) lpc.lastProject.showBorders()
				else lpc.lastProject.lighten();
			}
		}
		
		private function onLPCComplete(e:Event):void 
		{
			_cntProjects.removeChild( e.currentTarget as DisplayObject );
			if ( !_cntProjects.numChildren ) 
			{
				Config.cntMain.removeChild( _cntProjects );
				_dispatcher.dispatchEvent( new Event( Event.COMPLETE ) );
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function sortProjects():Array
		{
			var a:Array = [];
			var aw:Array = copyArray( Config.worksDatas );
			var al:Array = copyArray( Config.labDatas );
			
			while ( a.length < 3 )
			{
				if ( aw[ 0 ].pubdate < al[ 0 ] )
					a.push( al.shift() );
				else
					a.push( aw.shift() );
			}
			
			aw =
			al = null;
			
			return a;
		}
		
		private function copyArray( a:Array ):Array
		{
			var copy:Array = [];
			var n:int = a.length;
			for ( var i:int; i < n; ++i )
				copy[ i ] = a[ i ];
			
			return copy;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			while ( Config.cntMain.numChildren ) Config.cntMain.removeChildAt( 0 );
			
			_cntProjects = new Sprite();
			Config.cntMain.addChild( _cntProjects );
			
			var lpc:LastProjectContainer;
			var a:Array = sortProjects();
			var n:int = a.length;
			var px:Number = -10;
			for ( var i:int; i < n; ++i )
			{
				lpc = new LastProjectContainer();
				lpc.lastProject.linkToProject( a[ i ].title, a[ i ].preview, a[ i ].section );
				lpc.x = px;
				px += 322;
				lpc.addEventListener( LastProject.OVER, onLastProjectOver, true );
				lpc.addEventListener( LastProject.OUT, onLastProjectOut, true );
				lpc.addEventListener( Event.COMPLETE, onLPCComplete );
				_cntProjects.addChild( lpc );
			}
		}
		
		public function deactivate():void
		{			
			_killing = true;
			
			var i:int = _cntProjects.numChildren;
			while ( --i > -1 )
				LastProjectContainer( _cntProjects.getChildAt( i ) ).kill( i );
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_dispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}