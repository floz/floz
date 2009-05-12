
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.projects 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import main.Config;
	import main.ProjectEvent;
	
	public class ProjectsCtrl 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dispatcher:EventDispatcher;
		private var _datasProjects:Array;
		
		private var _cntProjects:Sprite;
		private var _btContainer:BtContainer;
		private var _killing:Boolean;
		
		private var _currentIdx:int;
		private var _idxMax:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ProjectsCtrl() 
		{
			_dispatcher = new EventDispatcher();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onProjectOver(e:Event):void 
		{
			var i:int = _cntProjects.numChildren;
			var pc:ProjectContainer;
			while ( --i > -1 )
			{
				pc = _cntProjects.getChildAt( i ) as ProjectContainer;
				if ( pc == e.currentTarget ) pc.project.hideBorders()
				else pc.project.darken();
			}
		}
		
		private function onProjectOut(e:Event):void 
		{
			var i:int = _cntProjects.numChildren;
			var pc:ProjectContainer;
			while ( --i > -1 )
			{
				pc = _cntProjects.getChildAt( i ) as ProjectContainer;
				if ( pc == e.currentTarget ) pc.project.showBorders()
				else pc.project.lighten();
			}
		}
		
		private function onProjectSelect(e:ProjectEvent):void 
		{
			var projectEvent:ProjectEvent = new ProjectEvent( ProjectEvent.PROJECT_SELECT );
			projectEvent.index = e.index;
			projectEvent.section = e.section;
			
			_dispatcher.dispatchEvent( projectEvent );
		}
		
		private function onPCComplete(e:Event):void 
		{
			var pc:ProjectContainer = e.currentTarget as ProjectContainer
			pc.removeEventListener( Project.OVER, onProjectOver, true );
			pc.removeEventListener( Project.OUT, onProjectOut, true );
			pc.removeEventListener( Event.COMPLETE, onPCComplete );			
			_cntProjects.removeChild( pc );
			
			if ( _killing )
			{
				if ( !_cntProjects.numChildren ) 
				{
					Config.cntMain.removeChild( _cntProjects );
					_dispatcher.dispatchEvent( new Event( Event.COMPLETE ) );
				}
			}
			else
			{
				if ( !_cntProjects.numChildren ) display();
			}
		}
		
		private function onBtComplete(e:Event):void 
		{
			if ( e.currentTarget.parent ) 
			{
				_btContainer.removeEventListener( Event.COMPLETE, onBtComplete );
				Config.cntMain.removeChild( e.currentTarget as DisplayObject );
			}
		}
		
		private function onPrev(e:Event):void 
		{
			--_currentIdx;
			displayBt();
		}
		
		private function onNext(e:Event):void 
		{
			++_currentIdx;
			displayBt();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function display():void
		{
			var idx:int;
			var idxAct:int = _currentIdx * 6;
			var n:int = _datasProjects.length - idxAct;
			
			var pc:ProjectContainer = new ProjectContainer();
			var px:Number = 0;			
			for ( var i:int; i < n; ++i )
			{				
				idx = int( idxAct + i );
				pc = new ProjectContainer();
				pc.project.linkToProject( _datasProjects[ idx ].title, _datasProjects[ idx ].preview, _datasProjects[ idx ].section, _datasProjects[ idx ].index );
				pc.x = px;
				px += 161;
				pc.addEventListener( Project.OVER, onProjectOver, true );
				pc.addEventListener( Project.OUT, onProjectOut, true );
				pc.addEventListener( ProjectEvent.PROJECT_SELECT, onProjectSelect, true );
				pc.addEventListener( Event.COMPLETE, onPCComplete );
				_cntProjects.addChild( pc );
			}
		}
		
		private function displayBt():void
		{
			removeProjects();
			
			if ( _currentIdx > 0 ) _btContainer.showPrev();
			else _btContainer.hidePrev();
			
			if ( _currentIdx < _idxMax ) _btContainer.showNext();
			else _btContainer.hideNext();
		}
		
		private function removeProjects():void
		{
			var i:int = _cntProjects.numChildren;
			while ( --i > -1 )
				ProjectContainer( _cntProjects.getChildAt( i ) ).kill( i );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			switch( Config.currentSection )
			{
				case Config.WORKS: _datasProjects = Config.worksDatas; break;
				case Config.LAB: _datasProjects = Config.labDatas;  break;
				default: throw new Error( "Impossibilité de lancé cette rubrique" ); break;
			}
			
			while ( Config.cntMain.numChildren ) Config.cntMain.removeChildAt( 0 );
			
			_cntProjects = new Sprite();
			Config.cntMain.addChild( _cntProjects );
			
			const n:int = _datasProjects.length;
			_idxMax = int( n / 6 );
			
			display();
			
			_btContainer = new BtContainer();
			_btContainer.y = 375;
			_btContainer.addEventListener( Bt.PREV, onPrev, true );
			_btContainer.addEventListener( Bt.NEXT, onNext, true );
			_btContainer.addEventListener( Event.COMPLETE, onBtComplete );
			Config.cntMain.addChild( _btContainer );
			
			if( _currentIdx < _idxMax ) _btContainer.showNext();
		}
		
		public function deactivate():void
		{
			_killing = true;
			
			removeProjects();
			
			_btContainer.removeEventListener( Bt.PREV, onPrev, true );
			_btContainer.removeEventListener( Bt.NEXT, onNext, true );
			_btContainer.kill();
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_dispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}