
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.projects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.easing.Cubic;
	import gs.TweenLite;
	
	public class ProjectContainer extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _enable:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var project:Project;
		public var msk:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ProjectContainer() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			TweenLite.killTweensOf( msk );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_enable = true;
			
			msk.y = -msk.height;
			TweenLite.to( msk, .4, { y: 0, ease: Cubic.easeIn, delay: parent.numChildren * .05, onComplete: projectInit } );
			
			project.addEventListener( Event.COMPLETE, onProjectDestroy );
			
			msk.mouseChildren =
			msk.mouseEnabled = false;
		}
		
		private function onProjectDestroy(e:Event):void 
		{
			TweenLite.to( msk, .4, { y: msk.height, ease: Cubic.easeOut, onComplete: destroy } );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function projectInit():void
		{
			if ( !_enable ) return;
			project.init();
		}
		
		private function destroy():void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function kill( delay:int ):void
		{
			if ( !_enable ) return;
			
			_enable = false;			
			project.kill( delay );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}