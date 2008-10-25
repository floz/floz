
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package objects.characters 
{	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Character extends MovieClip 
	{
		// Les différentes variables qui définissent les items que le perso à ramassé.
		protected var power:int = 1;
		protected var speed:int = 800;
		protected var type:String = "normal";
		protected var push:Boolean;
		
		public var cell:Point = new Point( 0, 0 );
		
		public function Character( texture:BitmapData = null ) 
		{
			if ( texture ) trace ( "texture given" );
		}
		
		// EVENTS
		
		// PRIVATE	
		
		// PUBLIC
		
	}
	
}