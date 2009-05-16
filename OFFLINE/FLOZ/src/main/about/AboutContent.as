
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.about 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import main.Config;
	
	public class AboutContent extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var txtPres:TextField;
		public var txtSkills:TextField;
		public var txtFlash:TextField;
		public var txtGraphic:TextField;
		public var txtMail:TextField;
		public var softwareGraphic:TextField;
		public var softwareFlash:TextField;
		public var flashTitle:TextField;
		public var graphicTitle:TextField;
		public var strk1:Sprite;
		public var strk2:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AboutContent() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);			
		}		
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			strk1.filters =
			strk2.filters = [ Config.glowFilter ];
			
			var a1:/*Object*/Array = [ 
				{ field: txtPres, text: Config.aboutDatas.presentation }, 
				{ field: txtFlash, text: Config.aboutDatas.skills.flash },  
				{ field: txtGraphic, text: Config.aboutDatas.skills.graphic } ];
			var i:int = a1.length;
			while ( --i > -1 )
				setInfos( a1[ i ].field, "basic_text", a1[ i ].text );
			
			a1 = [
				{ field: softwareFlash, text: Config.aboutDatas.softwares.flash },
				{ field: softwareGraphic, text: Config.aboutDatas.softwares.graphic } ];
			i = a1.length;
			while ( --i > -1 )
				setInfos( a1[ i ].field, "about_details", "SOFTWARE : " + a1[ i ].text );
			
			a1 = null;			
			
			var a2:/*TextField*/Array = [ flashTitle, graphicTitle ];
			i = a2.length;
			while ( --i > -1 )
				setInfos( a2[ i ], "basic_title_text", a2[ i ].text );
			
			a2 = null;			
			setInfos( txtSkills, "about_souscategorie", txtSkills.text );
			
			var filter:GlowFilter = Config.glowFilter.clone() as GlowFilter;
			filter.strength = 3;
			
			txtSkills.filters = 
			flashTitle.filters =
			softwareFlash.filters =
			softwareGraphic.filters =
			graphicTitle.filters = [ filter ];
			
			txtMail.embedFonts = true;
			txtMail.styleSheet = Config.styleSheet;
			txtMail.htmlText = "<span class='about_details'>MAIL: </span><span class='basic_url'>florian.zumbrunn@gmail.com</span>	<span class='about_details'>|    PHONE: </span><span class='basic_url'> +336 98 86 09 00</span><span class='about_details'>    |     CV: </span><span class='basic_url'><a href='http://www.floz.fr/assets/pdf/cv.pdf' target='_blank'>CLICK HERE</span>";
			txtMail.filters = [ filter ];
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function setInfos( tf:TextField, cssClass:String, text:String ):void
		{
			tf.embedFonts = true;
			tf.styleSheet = Config.styleSheet;
			tf.htmlText = "<span class='" + cssClass + "'>" + text + "</span>";
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}