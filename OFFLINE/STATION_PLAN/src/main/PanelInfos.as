
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class PanelInfos extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var imageHolder:ImageHolder;
		public var text:TextField;
		public var title:TextField;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PanelInfos() 
		{
			this.x = 980 + this.width;
			text.text = "Sélectionnez un des élements des listes ci dessus pour y voir les informations liées.";
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			TweenLite.to( this, .4, { x: 980 - this.width, ease: Quad.easeOut } );
		}
		
		public function displayInfos():void
		{
			title.text = Model.currentItem.label;
			text.htmlText = Model.currentItem.infoText + "\n\n" + Model.currentItem.text;
			
			if ( Model.currentItem.url == "" || Model.currentItem.url == "http://" )
				return;
			
			text.htmlText += "\n\n<a href='" + Model.currentItem.url + "' target='_blank'>Plus d'informations</a>";
		}
		
		public function reset():void
		{
			title.text = "";
			text.text = "Sélectionnez un des élements des listes ci dessus pour y voir les informations liées.";
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}