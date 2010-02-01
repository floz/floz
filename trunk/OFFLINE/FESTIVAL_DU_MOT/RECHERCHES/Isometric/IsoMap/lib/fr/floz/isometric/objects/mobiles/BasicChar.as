
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.objects.mobiles 
{
	import assets.CharNE_FC;
	import assets.CharNO_FC;
	import assets.CharSE_FC;
	import assets.CharSO_FC;
	import com.wtf.misc.AnimatedBitmap;
	import com.wtf.misc.MovieBitmap;
	import fr.floz.isometric.core.IsoDisplayObject;
	import fr.minuit4.display.Dummy;
	
	public class BasicChar extends IsoDisplayObject
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _sprite:MovieBitmap;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function BasicChar() 
		{
			_sprite = new MovieBitmap();
			_sprite.addAnimatedBitmap( new AnimatedBitmap( new CharNE_FC( 0, 0 ), 21, 28 ), "ne", 2 );
			_sprite.addAnimatedBitmap( new AnimatedBitmap( new CharNO_FC( 0, 0 ), 21, 28 ), "no", 2 );
			_sprite.addAnimatedBitmap( new AnimatedBitmap( new CharSE_FC( 0, 0 ), 21, 28 ), "se", 2 );
			_sprite.addAnimatedBitmap( new AnimatedBitmap( new CharSO_FC( 0, 0 ), 21, 28 ), "so", 2 );
			_sprite.setDefaultAnimation( "se" );
			
			_sprite.expositionTime = 6;
			
			_sprite.play();
			
			_sprite.x = -_sprite.width * .5;
			_sprite.y = -_sprite.height * .5 + 5;
			addChild( _sprite );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update():void
		{
			_sprite.update();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}