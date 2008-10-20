
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import fr.minuit4.tools.FPS;
	import objects.characters.Player;
	import plateau.Plateau;
	
	public class Main extends MovieClip
	{
		public var plateau:Plateau;
		
		public function Main() 
		{
			var p:Player = new Player();
			plateau.addPlayer( p );
			
			//addChild( new FPS() );
		}
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}