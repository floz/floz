﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.animation.rain 
{
	
	public class Pixel 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var px:Number;
		public var py:Number;
		public var vx:Number;
		public var vy:Number;
		public var c:uint;
		
		public var fx:Number;
		public var fy:Number;
		public var end:Boolean;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Pixel( px:Number, py:Number, color:uint, vx:Number = 0, vy:Number = 0) 
		{
			this.px = px;
			this.py = py;
			this.c = color;
			this.vx = vx;
			this.vy = vy;
			
			this.fx = px;
			this.fy = py;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}