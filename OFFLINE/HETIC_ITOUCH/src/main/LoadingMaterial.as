
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import fr.minuit4.effects.Loading;
	
	public class LoadingMaterial extends MovieClip
	{
		private var _loading:Loading;
		
		public function LoadingMaterial() 
		{
			_loading = new Loading( 0x7a7a7a, 32, 14 );
			_loading.x = ( this.width >> 1 ) - ( _loading.width >> 1 );
			_loading.y = ( this.height >> 1 ) - ( _loading.height >> 1 );
			addChild( _loading );
			
			_loading.play();
		}
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
		
		public function kill():void
		{
			_loading.kill();
		}
		
	}
	
}