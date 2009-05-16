
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.menu
{
	import com.asual.swfaddress.SWFAddress;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import main.Config;
	
	public class Menu extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Menu() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if ( e.currentTarget.getSectionName().toLowerCase() == Config.currentSection ) 
				return;
			
			SWFAddress.setValue( e.currentTarget.getSectionName().substr( 0, 1 ).toUpperCase() + e.currentTarget.getSectionName().substr( 1 ).toLowerCase() + "/" );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if ( Config.currentSection == Config.DETAILS && e.currentTarget.getSectionName() == Config.detailsSection )
				return;
			
			e.currentTarget.over();
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if ( Config.currentSection == Config.DETAILS && e.currentTarget.getSectionName() == Config.detailsSection )
				return;
			
			e.currentTarget.out();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function init():void
		{
			var mi:MenuItem;
			var n:int = Config.RUBRIQUES.length;
			for ( var i:int; i < n; ++i )
			{
				mi = new MenuItem( i, Config.RUBRIQUES[ i ] );
				mi.x = this.width;
				mi.x += i ? 1 : 0;
				addChild( mi );
				
				mi.addEventListener( MouseEvent.CLICK, onClick );
				mi.addEventListener( MouseEvent.MOUSE_OVER, onOver );
				mi.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			}
		}
		
		public function update():void
		{
			var mi:MenuItem;
			var i:int = numChildren;
			while ( --i > -1 )
			{
				mi = getChildAt( i ) as MenuItem;
				if ( Config.currentSection == Config.DETAILS )
				{
					if ( mi.getSectionName() == Config.detailsSection ) mi.select();
					else mi.deselect();
				}
				else
				{
					if ( mi.getSectionName() == Config.currentSection ) mi.select();
					else mi.deselect();
				}
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}