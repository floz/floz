
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import items.characters.Player;
	import plateau.Plateau;
	
	public class Main extends MovieClip
	{
		public var plateau:Plateau;
		
		public function Main() 
		{
			var p:Player = new Player();
			plateau.addPlayer( p );
		}
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}