
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
		
		public function divide( ratio:Number ):Segment
		{
			var newEnd:Point;
			if ( control )
			{
				var ratio1:Number = 1.0 - ratio;
				
				var newControl:Point = new Point( ratio * control.x + ratio1 * start.x, 
												  ratio * control.y + ratio1 * start.y );
				
				var temp:Point = new Point( ratio * end.x + ratio1 * control.x,
											ratio * end.y + ratio1 * control.y );
				
				newEnd = new Point( ratio * temp.x + ratio1 * newControl.x, 
									ratio * temp.y + ratio1 * newControl.y );
				
				var newCurrent:Segment = new Segment( start, newEnd, newControl );
				newCurrent.next = new Segment( newEnd, end );
				
				newControl = new Point( ratio1 * control.x + ratio * end.x,
										ratio1 * control.y + ratio * end.y );
				
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