
/**
 * @author Floz
 */
package singletons 
{
	import com.gskinner.performance.MethodTest;
	import com.gskinner.performance.TestSuite;
	
	public class TestSingleton extends TestSuite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var loops:uint = 1000000;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TestSingleton() 
		{
			name = "Appel de singleton";
			description = "Différentes méthodes pour appeller un singleton, et répercusion sur les perfs";
			iterations = 4;
			tareTest = new MethodTest(tare);			
			
			tests = [
				new MethodTest( directCall, null, "Singleton.getInstance()", 0, 1, "Appel via getInstance" ),
				new MethodTest( simplifiedByVar, null, "mySingletonVar", 0, 1, "Appel via mySingletonVar directement" ),
				new MethodTest( simplifiedByConst, null, "mySingletonConst", 0, 1, "Appel via mySingletonConst directement" ),
				new MethodTest( singletonViaStaticVar, null, "static var", 0, 1, "Appel via static var" ),
				new MethodTest( singletonViaStaticConst, null, "static const", 0, 1, "Appel via static const" )
			];
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function tare():void
		{
			var i:uint = loops;
			while ( --i > -1 ) {}
		}
		
		private function directCall():void
		{
			var i:uint = loops;
			while ( --i > -1 )
				Singleton.getInstance().test();
		}
		
		private function simplifiedByVar():void
		{
			var i:uint = loops;
			while ( --i > -1 )
				mySingletonVar.test();
		}
		
		private function simplifiedByConst():void
		{
			var i:uint = loops;
			while ( --i > -1 )
				mySingletonConst.test();
		}
		
		private function singletonViaStaticVar():void
		{
			var i:uint = loops;
			while ( --i > -1 )
				MyStaticSingleton.instanceVar.test();
		}
		
		private function singletonViaStaticConst():void
		{
			var i:uint = loops;
			while ( --i > -1 )
				MyStaticSingleton.instanceConst.test();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}