
/**
 * @author Floz
 */
package singletons 
{
	
	public class MyStaticSingleton
	{
		
		public static var instanceVar:Singleton = Singleton.getInstance();
		public static const instanceConst:Singleton = Singleton.getInstance();
	}
	
}