
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	public class IndexOfTests extends Sprite
	{
		private var a:Array;
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IndexOfTests() 
		{
			var s1:Sprite = new Sprite();
			var s2:Sprite = new Sprite();
			var s3:Sprite = new Sprite();
			
			a = [ s1, s2, s3 ];
			
			var i:int;
			var n:int = 1000000;
			var debut:Number = getTimer();
			for ( i = 0; i < n; ++i )
			{
				a.indexOf( s1 );
			}
			trace( getTimer() - debut );
			
			debut = getTimer();
			for ( i = 0; i < n; ++i )
			{
				getIndex1( s1 );
			}
			trace( getTimer() - debut );
			
			debut = getTimer();
			for ( i = 0; i < n; ++i )
			{
				getIndex2( s1 );
			}
			trace( getTimer() - debut );
			
			debut = getTimer();
			for ( i = 0; i < n; ++i )
			{
				getIndex3( s1 );
			}
			trace( getTimer() - debut );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getIndex1( s:Sprite ):int
		{
			var i:int;
			var n:int = a.length;
			
			for ( ; i < n; ++i )
				if ( s === a[ i ] ) return i;
			
			return -1;
		}
		
		private function getIndex2( s:Sprite ):int
		{
			var i:int = a.length;
			
			while ( --i > -1 )
				if ( s === a[ i ] ) return i;
			
			return -1;
		}
		
		private function getIndex3( s:Sprite ):int
		{
			var i:uint;
			var n:int = a.length;
			
			for ( ; i < n; ++i )
				if ( s === a[ i ] ) return i;
			
			return -1;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}