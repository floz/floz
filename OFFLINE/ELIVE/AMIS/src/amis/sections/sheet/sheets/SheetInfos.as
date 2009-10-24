
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet.sheets 
{
	import amis.sections.sheet.apercus.TextApercu;
	import assets.GAvatar2;
	import assets.GGeneralBackground;
	import assets.GScrollbarBackground;
	import assets.GScrollbarSlider;
	import elive.core.users.User;
	import elive.core.users.UserStats;
	import elive.utils.EliveUtils;
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	
	public class SheetInfos extends Sheet
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cntGlobal:Sprite;
		private var _cntContent:Sprite;
		private var _scrollbar:VScrollbar;
		
		private var _cntTop:Sprite;
		private var _avatarHolder:Bitmap;
		
		private var _cntBottom:Sprite;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SheetInfos() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			_avatarHolder.bitmapData.dispose();
			_avatarHolder.bitmapData = null;
			_avatarHolder = null;
			
			_scrollbar.dispose();
			_scrollbar = null;
			
			_cntBottom = null;
			_cntTop = null;
			_cntContent = null;
			_cntGlobal = null;
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_cntGlobal = new Sprite();
			addChild( _cntGlobal );
			
			_cntContent = new Sprite();
			_cntGlobal.addChild( _cntContent );
			
			var mask:Sprite = new Sprite();
			var g:Graphics = mask.graphics;
			g.beginFill( 0x00ff00 );
			g.drawRect( 0, 0, 266, 288 );
			g.endFill();
			_cntGlobal.addChild( mask );
			
			_scrollbar = new VScrollbar( new GScrollbarBackground(), new GScrollbarSlider() );
			_scrollbar.link( _cntContent, mask );
			_scrollbar.x = 265;
			addChild( _scrollbar );
			_scrollbar.enableBlur = true;
			
			_cntTop = new Sprite();
			_cntTop.y = 5;
			_cntContent.addChild( _cntTop );
			
			_cntBottom = new Sprite();
			_cntContent.addChild( _cntBottom );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function buildCntTop():void
		{
			_cntTop.addChild( new GGeneralBackground() );
			
			_avatarHolder = new Bitmap( new GAvatar2( 0, 0 ), PixelSnapping.AUTO, true );
			_avatarHolder.x =
			_avatarHolder.y = 7;
			_cntTop.addChild( _avatarHolder );
			
			var tf:TextField = EliveUtils.getPreconfigureTextField();
			EliveUtils.configureText( tf, "score", _user.points.toString() + " pts" );
			tf.x = _avatarHolder.width + 10;
			tf.y = _avatarHolder.height * .5 + _avatarHolder.y - tf.textHeight * .5;
			_cntTop.addChild( tf );
		}
		
		private function buildCntBottom():void
		{
			_cntBottom.y = _cntTop.y + _cntTop.height;
			
			var apercu:TextApercu = new TextApercu();
			apercu.setTitleText( "STATISTIQUES des (e)lives" );
			
			var stats:UserStats = _user.getStats();
			var total:int = stats.won - stats.lost - stats.refused;
			if ( total < 0 ) total = 0;
			var text:String = "Totaux : " + total;
			text += "\nRéussis : " + stats.won;
			text += "\nEn cours : " + stats.current;
			text += "\nPerdus : " + stats.lost;
			text += "\nRefusés : " + stats.refused;
			apercu.setContentText( text );
			
			_cntBottom.addChild( apercu );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function linkTo(user:User):void 
		{
			super.linkTo(user);
			buildCntTop();
			buildCntBottom();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}