
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.details 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import main.Config;
	
	public class DetailsText extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _project:Object;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var strk:Sprite;
		public var titleClient:TextField;
		public var titleJob:TextField;
		public var titleTechno:TextField;
		public var titleDesc:TextField;
		public var titleUrl:TextField;
		public var txtClient:TextField;
		public var txtJob:TextField;
		public var txtTechno:TextField;
		public var txtDesc:TextField;
		public var txtUrl:TextField;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DetailsText() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			strk.filters = [ Config.glowFilter ];
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkToProject( project:Object ):void
		{
			if ( !project)
				return;
			
			this._project = project;
			
			var txt:TextField;
			var a:Array = [ txtClient, txtJob, txtDesc, txtTechno, txtUrl ];
			var i:int = a.length;
			while ( --i > -1 )
			{
				txt = a[ i ];
				
				txt.embedFonts = true;
				txt.styleSheet = Config.styleSheet;
			}
			
			txtClient.htmlText = "<span class='basic_text'>" + project.client + "</span>";
			txtJob.htmlText = "<span class='basic_text'>" + project.job + "</span>";
			txtClient.htmlText = "<span class='basic_text'>" + project.client + "</span>";
			txtTechno.htmlText = "<span class='basic_text'>" + project.technos + "</span>";
			txtDesc.htmlText = "<span class='basic_text'>" + project.desc + "</span>";
			txtUrl.htmlText = ( project.url && project.url != "" ) ? "<a href='" + project.url + "' class='basic_url' target='_blank'>View the project</a>" : "<span class='basic_url'>Project offline</span>"
			
			var filter:GlowFilter = Config.glowFilter.clone() as GlowFilter;
			filter.strength = 3.
			
			txtUrl.filters = [ filter ];
			
			a = [ titleClient, titleJob, titleTechno, titleUrl, titleDesc ];
			i = a.length;
			while ( --i > -1 )
			{
				txt = a[ i ];
				
				txt.embedFonts = true;
				txt.styleSheet = Config.styleSheet;
				
				txt.htmlText = "<span class='basic_title_text'>" + txt.text + "</span>";
				
				txt.filters = [ filter ];
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}