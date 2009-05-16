
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.details 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import gs.easing.Cubic;
	import gs.TweenLite;
	import main.Bt;
	import main.BtContainer;
	import main.Config;
	import main.ProjectEvent;
	
	public class DetailsContainer extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _enable:Boolean;
		private var _currentIdx:int;
		private var _idxMax:int;
		private var _section:String;
		
		private var _datas:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var dDiaporama:DetailsDiaporama;
		public var dText:DetailsText;
		public var msk1:Sprite;
		public var msk2:Sprite;
		public var btContainer:BtContainer;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DetailsContainer() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			btContainer.removeEventListener( Bt.PREV, onPrev, true );
			btContainer.removeEventListener( Bt.NEXT, onNext, true );
			
			TweenLite.killTweensOf( msk1 );
			TweenLite.killTweensOf( dText );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			msk1.y = -msk1.height - 10;
			dText.alpha = 0;
			
			TweenLite.to( msk1, .4, { y: -5, ease: Cubic.easeIn, onComplete: onDiaporamaAppear } );
			TweenLite.to( dText, .2, { alpha: 1, ease: Cubic.easeIn, delay: .2 } );
			
			var value:String = Config.detailsSection == Config.WORKS ? Config.WORKS : Config.LAB;
			
			btContainer.addEventListener( Bt.PREV, onPrev, true );
			btContainer.addEventListener( Bt.NEXT, onNext, true );
			
			this.x = 2;			
			_enable = true;
		}
		
		private function onPrev(e:Event):void 
		{
			--_currentIdx;
			
			var projectEvent:ProjectEvent = new ProjectEvent( ProjectEvent.PROJECT_SELECT );
			projectEvent.index = _currentIdx;
			projectEvent.section = _section;
			
			dispatchEvent( projectEvent );
		}
		
		private function onNext(e:Event):void 
		{
			++_currentIdx;
			
			var projectEvent:ProjectEvent = new ProjectEvent( ProjectEvent.PROJECT_SELECT );
			projectEvent.index = _currentIdx;
			projectEvent.section = _section;
			
			dispatchEvent( projectEvent );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function onDiaporamaAppear():void
		{
			dDiaporama.showPanel();
			
			btContainer.showNext();
			btContainer.showPrev();
		}
		
		private function displayBt():void
		{
			if ( _currentIdx > 0 ) btContainer.activatePrev();
			else btContainer.deactivatePrev();
			
			if ( _currentIdx < _idxMax - 1 ) btContainer.activateNext();
			else btContainer.deactivateNext();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkToProject( project:Object ):void
		{
			_currentIdx = project.index;
			_section = project.section.toLowerCase();
			_datas = project.section.toLowerCase() == Config.WORKS ? Config.worksDatas : Config.labDatas;
			_idxMax = _datas.length;
			
			switchProject( _currentIdx );
		}
		
		public function switchProject( index:int ):void
		{
			_currentIdx = index;
			dDiaporama.linkToProject( _datas[ index ] );
			dText.linkToProject( _datas[ index ] );
			
			displayBt();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}