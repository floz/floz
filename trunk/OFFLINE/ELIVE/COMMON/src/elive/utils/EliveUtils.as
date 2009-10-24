
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.utils 
{
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import fr.minuit4.core.configuration.Config;
	import fr.minuit4.core.configuration.Configuration;
	
	public class EliveUtils 
	{
		
		public static function configureText( tf:TextField, cssClass:String, text:String = null ):void
		{
			if ( !Config.getProperty( "css" ) ) 
			{
				if ( text ) tf.text = text;
				return;
			}
			
			tf.embedFonts = true;
			tf.styleSheet = Config.getProperty( "css" );
			tf.htmlText = "<span class='" + cssClass + "'>" + ( !text ? tf.text : text ) + "</span>";
		}
		
		public static function getPreconfigureTextField():TextField
		{
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			return tf;
		}
		
		public static function getColorTransform( color:uint ):ColorTransform
		{
			var r:uint = color >> 16;
			var g:uint = ( color >> 8 ) & 0xff;
			var b:uint = color & 0xff;
			
			return new ColorTransform( 1, 1, 1, 1, r, g, b );
		}
		
	}
	
}