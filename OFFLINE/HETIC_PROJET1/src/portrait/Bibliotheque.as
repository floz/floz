
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	public class Bibliotheque extends MovieClip
	{
		public var zUp:SimpleButton;
		public var zDown:SimpleButton;
		public var cnt:MovieClip;
		
		private var library:BitmapDataLibrary;
		
		public function Bibliotheque() 
		{
			
		}
		
		// EVENTS
		
		// PRIVATE
		
		private function getAncestor( child:DisplayObject, type:* ):*
		{
			
		}
		
		// PUBLIC
		
		public function load( sexe:String, categorie:String ):void
		{
			library = new BitmapDataLibrary();
		}
		
	}
	
}