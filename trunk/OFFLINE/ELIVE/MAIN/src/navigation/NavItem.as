
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package navigation 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class NavItem extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var id:String;
		public var title:String;
		public var url:String;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NavItem( id:String, title:String, url:String ) 
		{
			this.id = id;
			this.title = title;
			this.url = url;
			
			this.mouseChildren = false;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function over():void
		{
			this.alpha = .75;
		}
		
		public function out():void
		{
			this.alpha = 1;
		}
		
		public function select():void
		{
			this.alpha = .5;
		}
		
		public function deselect():void
		{
			this.alpha = 1;
		}
		
		public function setSkin( skin:DisplayObject ):void
		{
			addChild( skin );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}