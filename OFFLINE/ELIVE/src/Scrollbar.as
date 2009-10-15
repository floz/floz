
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import assets.GContent;
	import assets.GScrollbarBackground;
	import assets.GScrollbarBtDown;
	import assets.GScrollbarBtUp;
	import assets.GScrollbarSlider;
	import elive.xmls.EliveXML;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import fr.minuit4.net.loaders.types.DatasLoader;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	
	public class Scrollbar extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Scrollbar() 
		{			
			var url:String = "xml/action_sheet.xml";
			var datasLoader:DatasLoader = new DatasLoader( url );
			datasLoader.addEventListener( Event.COMPLETE, handleLoadComplete );
			datasLoader.load();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function handleLoadComplete(e:Event):void 
		{
			var datasLoader:DatasLoader = e.currentTarget as DatasLoader;
			var datas:String = datasLoader.getItemLoaded();
			trace( EliveXML.parseComments( XML( datas ), true )[ 0 ].getUser() );
			
			var gContent:GContent = new GContent();
			gContent.x = 50;
			gContent.y = 50;
			addChild( gContent );
			
			var sb:VScrollbar = new VScrollbar( new GScrollbarBackground(), new GScrollbarSlider(), new GScrollbarBtUp(), new GScrollbarBtDown(), true );
			sb.x = gContent.width + gContent.x;
			sb.y = 50;
			addChild( sb );
			
			sb.link( gContent, new Rectangle( 0, 0, gContent.width, 250 ) );
			sb.enableBlur = true;
			
			sb.height = 250;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}