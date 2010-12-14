
/**
 * @author Floz
 */
package nums 
{
	import com.gskinner.performance.MethodTest;
	import com.gskinner.performance.TestSuite;
	
	public class TestNumTypes extends TestSuite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		public var loops:uint = 1000000;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TestNumTypes() 
		{
			name = "Test de boucle sur différents types";
			description = name
			iterations = 4;
			
			tests = [
				new MethodTest( whileUint, null, "while uint", 0, 1, "while uint" ),
				new MethodTest( whileInt, null, "while int", 0, 1, "while int" ),
				new MethodTest( whileNumber, null, "while Number", 0, 1, "while Number" ),
				new MethodTest( forUint, null, "for uint", 0, 1, "for uint" ),
				new MethodTest( forInt, null, "for int", 0, 1, "for int" ),
				new MethodTest( forNumber, null, "for Number", 0, 1, "while Number" )
			];
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function whileUint():void
		{
			var i:uint = loops;
			while ( --i > -1 ) { };
		}
		
		private function whileInt():void
		{
			var i:int = loops;
			while ( --i > -1 ) { };
		}
		
		private function whileNumber():void
		{
			var i:Number = loops;
			while ( --i > -1 ) { };
		}
		
		private function forUint():void
		{
			var n:uint = loops;
			for ( var i:uint; i < n; ++i ) { };
		}
		
		private function forInt():void
		{
			var n:int = loops;
			for ( var i:int; i < n; ++i ) { };
		}
		
		private function forNumber():void
		{
			var n:Number = loops;
			for ( var i:Number; i < n; ++i ) { };
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}