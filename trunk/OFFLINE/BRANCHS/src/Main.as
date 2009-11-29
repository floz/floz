
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _branchManager:BranchManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_branchManager = new BranchManager( stage.stageWidth, stage.stageHeight, false, 0xffffff, 0x000000 );
			addChild( _branchManager );
			
			stage.addEventListener( MouseEvent.MOUSE_MOVE, clickHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function clickHandler(e:MouseEvent):void 
		{
			_branchManager.addBranch( stage.mouseX, stage.mouseY );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}