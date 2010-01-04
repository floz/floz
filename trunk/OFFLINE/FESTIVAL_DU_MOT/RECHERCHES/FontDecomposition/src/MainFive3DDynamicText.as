
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import net.badimon.five3D.display.DynamicText3D;
	import net.badimon.five3D.display.Scene3D;
	import net.badimon.five3D.typography.HelveticaBold;
	
	public class MainFive3DDynamicText extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainFive3DDynamicText() 
		{			
			var scene:Scene3D = new Scene3D();
			addChild( scene );
			
			var font:HelveticaBold = new HelveticaBold();
			var dText:DynamicText3D = new DynamicText3D( font );
			dText.text = "HELLO !";
			dText.size = 70;
			scene.addChild( dText );
			
			dText.x = ( stage.stageWidth - getTextWidth( dText.text ) ) * .5;
			dText.y = ( stage.stageHeight - HelveticaBold.instance.getHeight() ) * .5;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getTextWidth( text:String ):Number
		{
			var size:Number = 0;
			var n:int = text.length;
			for ( var i:int; i < n; ++i )
				size += HelveticaBold.instance.getWidth( text.substr( i, 1 ) );
			
			return size;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}