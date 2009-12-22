﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.geom 
{
	import flash.geom.Point;
	
	/**
	 * Based on :
	 * http://philippe.elsass.me/2009/06/as3-parametric-path-drawing/
	 */
	public class Segment 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var start:Point;
		public var end:Point;
		public var control:Point;
		
		public var next:Segment;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Segment( start:Point, end:Point, control:Point = null ) 
		{
			this.start = start;
			this.end = end;
			this.control = control;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function subdivide( ratio:Number ):Segment
		{
			ratio = .5; // must be !
			if ( ratio < 0 ) ratio = 0;
			if ( ratio > 1 || isNaN( ratio ) ) ratio = 1;
			
			var newEnd:Point;
			if ( control )
			{
				var ratio1:Number = 1.0 - ratio;
				
				var newControl:Point = new Point( ( control.x + start.x ) * .5, ( control.y + start.y ) * .5 );
				
				var temp:Point = new Point( ( end.x + control.x ) * .5,
											( end.y + control.y ) * .5 );
				
				newEnd = new Point( ( temp.x + newControl.x ) * .5, 
									( temp.y + newControl.y ) * .5 );
				
				var newCurrent:Segment = new Segment( start, newEnd, newControl );
				newCurrent.next = new Segment( newEnd, end );
				
				newControl = new Point( (control.x + end.x ) * .5,
										(control.y + end.y ) * .5 );
				
				newCurrent.next.control = newControl;
				
				return newCurrent;
			}
			else
			{
				newEnd = new Point( start.x + ratio * ( end.x - start.x ), start.y + ratio * ( end.x - start.x ) );
				return new Segment( start, newEnd );
			}
		}
		
		/**
		 * http://segfaultlabs.com/graphics/qbezierlen/
		 * @return
		 */
		public function getLength():Number
		{
			if ( control )
			{
				var dax:Number = 2 * control.x;
				var day:Number = 2 * control.y;
				
				var ax:Number = start.x - dax + end.x;
				var ay:Number = start.y - day + end.y;
				var bx:Number = dax - 2 * start.x;
				var by:Number = day - 2 * start.y;
				
				var a:Number = 4 * ( ax * ax + ay * ay );
				var b:Number = 4 * ( ax * bx + ay * by );
				var c:Number = bx * bx + by * by;
				
				var sAbc:Number = 2 * Math.sqrt( a + b + c );
				var a2:Number = Math.sqrt( a );
				var a32:Number = 2 * a * a2;
				var c2:Number = 2 * Math.sqrt( c );
				var ba:Number = b / a2;
				
				return (a32 * sAbc + a2 * b * (sAbc - c2) + (4 * c * a - b * b) * Math.log((2 * a2 + ba + sAbc) / (ba + c2))) / (4 * a32);
			}
			else return end.subtract( start ).length;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}