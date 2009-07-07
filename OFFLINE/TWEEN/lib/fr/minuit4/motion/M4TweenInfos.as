﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.motion 
{
	
	public class M4TweenInfos 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var property:String;
		public var startValue:Number;
		public var endValue:Number;
		public var duration:Number;
		public var startTime:Number;
		public var endTime:Number;
		
		public var onInit:Function;
		public var onUpdate:Function;
		public var onComplete:Function;
		public var onInitParams:Array;
		public var onUpdateParams:Array;
		public var onCompleteParams:Array;
		public var easing:Function;
		public var delay:Number;
		public var active:Boolean;
		public var complete:Boolean;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function M4TweenInfos( property:String, startValue:Number, endValue:Number, duration:Number ) 
		{
			this.property = property;
			this.startValue = startValue;
			this.endValue = endValue;
			this.duration = duration;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}