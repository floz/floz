
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
		//public var btBackToWorks:MovieClip;
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
			
			//btBackToWorks.removeEventListener( MouseEvent.MOUSE_OVER, onOver );
			//btBackToWorks.removeEventListener( MouseEvent.MOUSE_OUT, onOut );
			//btBackToWorks.removeEventListener( MouseEvent.CLICK, onClick );
			
			btContainer.removeEventListener( Bt.PREV, onPrev, true );
			btContainer.removeEventListener( Bt.NEXT, onNext, true );
			
			TweenLite.killTweensOf( msk1 );
			TweenLite.killTweensOf( dText );
			//TweenLite.killTweensOf( btBackToWorks );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			msk1.y = -msk1.height - 10;
			dText.alpha = 0;
			//btBackToWorks.alpha =
			//btBackToWorks.y = 0;
			
			TweenLite.to( msk1, .4, { y: -5, ease: Cubic.easeIn, onComplete: onDiaporamaAppear } );
			TweenLite.to( dText, .2, { alpha: 1, ease: Cubic.easeIn, delay: .2 } );
			
			dDiaporama.addEventListener( Event.COMPLETE, onPanelComplete );
			
			var value:String = Config.detailsSection == Config.WORKS ? Config.WORKS : Config.LAB;
			//var txt1:TextField = btBackToWorks.cnt.txt1;
			//var txt2:TextField = btBackToWorks.cnt.txt2;
			//txt1.embedFonts =
			//txt2.embedFonts = true;
			//txt1.styleSheet =
			//txt2.styleSheet = Config.styleSheet;
			//txt1.htmlText =
			//txt2.htmlText = "<span class='bt_backtoworks'>BACK TO " + value.toUpperCase() + "</span>";
			//
			//btBackToWorks.cnt.ico1.filters =
			//btBackToWorks.cnt.ico2.filters =
			//txt1.filters =
			//txt2.filters = [ Config.glowFilter ];
			
			//btBackToWorks.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			//btBackToWorks.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			//btBackToWorks.addEventListener( MouseEvent.CLICK, onClick );
			
			btContainer.addEventListener( Bt.PREV, onPrev, true );
			btContainer.addEventListener( Bt.NEXT, onNext, true );
			
			this.x = 2;			
			_enable = true;
		}
		
		//private function onOver(e:MouseEvent):void 
		//{
			//TweenLite.to( btBackToWorks.cnt, .2, { y: - 35, ease: Cubic.easeOut } );
		//}
		//
		//private function onOut(e:MouseEvent):void 
		//{
			//TweenLite.to( btBackToWorks.cnt, .2, { y: -4, ease: Cubic.easeOut } );
		//}
		
		private function onClick(e:MouseEvent):void 
		{
			//btBackToWorks.mouseChildren =
			//btBackToWorks.mouseEnabled = false;
			
			Config.tempSection = Config.detailsSection == Config.WORKS ? formatText( Config.WORKS ) : formatText( Config.LAB );
			kill();
		}
		
		private function onPrev(e:Event):void 
		{
			--_currentIdx;
			
			//switchProject();
			
			var projectEvent:ProjectEvent = new ProjectEvent( ProjectEvent.PROJECT_SELECT );
			projectEvent.index = _currentIdx;
			projectEvent.section = _section;
			
			dispatchEvent( projectEvent );
		}
		
		private function onNext(e:Event):void 
		{
			++_currentIdx;
			//displayBt();
			//switchProject();
			
			var projectEvent:ProjectEvent = new ProjectEvent( ProjectEvent.PROJECT_SELECT );
			projectEvent.index = _currentIdx;
			projectEvent.section = _section;
			
			dispatchEvent( projectEvent );
		}
		
		private function onPanelComplete(e:Event):void 
		{
			TweenLite.to( msk1, .4, { y: msk1.height + 10, ease: Cubic.easeOut, onComplete: destroy } );
			TweenLite.to( dText, .4, { alpha: 0, ease: Cubic.easeOut } );
			//TweenLite.to( btBackToWorks, .3, { alpha: 0, y: 0, ease: Cubic.easeOut } );
			
			btContainer.kill();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function onDiaporamaAppear():void
		{
			dDiaporama.showPanel();
			
			//TweenLite.to( btBackToWorks, .3, { y: -28, alpha: 1, ease: Cubic.easeIn } );
			
			btContainer.showNext();
			btContainer.showPrev();
		}
		
		private function destroy():void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		private function displayBt():void
		{
			if ( _currentIdx > 0 ) btContainer.activatePrev();
			else btContainer.deactivatePrev();
			
			if ( _currentIdx < _idxMax - 1 ) btContainer.activateNext();
			else btContainer.deactivateNext();
		}
		
		private function formatText( txt:String ):String
		{
			return txt.substr( 0, 1 ).toUpperCase() + txt.substr( 1 ).toLowerCase();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkToProject( project:Object ):void
		{
			_currentIdx = project.index;
			_section = project.section.toLowerCase();
			_datas = project.section.toLowerCase() == Config.WORKS ? Config.worksDatas : Config.labDatas;
			_idxMax = _datas.length;
			
			switchProject();
		}
		
		public function switchProject():void
		{
			dDiaporama.linkToProject( _datas[ _currentIdx ] );
			dText.linkToProject( _datas[ _currentIdx ] );
			
			displayBt();
		}
		
		public function kill():void
		{
			dDiaporama.hidePanel();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}