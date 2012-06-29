﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import fr.floz.typography.DynamicText;
	import net.badimon.five3D.typography.HelveticaBold;
	
	public class MainDynamicTextFloz extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainDynamicTextFloz() 
		{
			var dynamicText:DynamicText = new DynamicText( "He d o .", new HelveticaBold() );
			dynamicText.size = 150;
			addChild( dynamicText );
			
			dynamicText.x = ( stage.stageWidth - dynamicText.width ) * .5;
			dynamicText.y = ( stage.stageHeight - dynamicText.height ) * .5;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}