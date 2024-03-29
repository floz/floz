
/** Original equations from Robert Penner */
package fr.minuit4.motion.easing 
{
	public class Elastic
	{
		private static const _2PI:Number = Math.PI * 2;
		
		/**
		* @param t		Specifies the current time, between 0 and duration inclusive. 
		* @param b		Specifies the initial value of the animation property. 
		* @param c		Specifies the total change in the animation property. 
		* @param d		Specifies the duration of the motion. 
		* @return		The value of the interpolated property at the specified time.
		*/
		public static function easeIn (t:Number, b:Number, c:Number, d:Number, a:Number = 0, p:Number = 0):Number
		{
			var s:Number;
			if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
			if (!a || a < Math.abs(c)) { a=c; s = p/4; }
			else s = p/_2PI * Math.asin (c/a);
			return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*_2PI/p )) + b;
		}
		
		/**
		* @param t		Specifies the current time, between 0 and duration inclusive. 
		* @param b		Specifies the initial value of the animation property. 
		* @param c		Specifies the total change in the animation property. 
		* @param d		Specifies the duration of the motion. 
		* @return		The value of the interpolated property at the specified time.
		*/
		public static function easeOut (t:Number, b:Number, c:Number, d:Number, a:Number = 0, p:Number = 0):Number 
		{
			var s:Number;
			if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
			if (!a || a < Math.abs(c)) { a=c; s = p/4; }
			else s = p/_2PI * Math.asin (c/a);
			return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*_2PI/p ) + c + b);
		}
		
		/**
		* @param t		Specifies the current time, between 0 and duration inclusive. 
		* @param b		Specifies the initial value of the animation property. 
		* @param c		Specifies the total change in the animation property. 
		* @param d		Specifies the duration of the motion. 
		* @return		The value of the interpolated property at the specified time.
		*/
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number, a:Number = 0, p:Number = 0):Number
		{
			var s:Number;
			if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (!p) p=d*(.3*1.5);
			if (!a || a < Math.abs(c)) { a=c; s = p/4; }
			else s = p/_2PI * Math.asin (c/a);
			if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*_2PI/p )) + b;
			return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*_2PI/p )*.5 + c + b;
		}
		
	}
	
}