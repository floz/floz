/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  elive.ui.sousmenu 
{
	import assets.fonts.FAkkurat;
	import assets.GBtSousMenu;
	import elive.utils.EliveUtils;
	import flash.text.TextFormat;
	import fr.minuit4.core.interfaces.IDisposable;
	import fr.minuit4.motion.M4Tween;
	
	public class SousMenuItem extends GBtSousMenu implements IDisposable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _overColor:uint;
		private var _format:TextFormat;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var title:String;
		public var sousRubId:String;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SousMenuItem( title:String, sousRubId:String, overColor:uint ) 
		{
			this.title = title;
			this.sousRubId = sousRubId;
			this._overColor = overColor;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_format = new TextFormat( new FAkkurat().fontName );
			_format.color = 0x000000;
			tf.defaultTextFormat = _format;
			
			bg.alpha = 0;			
			this.mouseChildren = false;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function over():void
		{
			_format.color = _overColor;			
			
			bg.alpha = .6;
			M4Tween.to( bg, .25, { alpha: 1 } );
		}
		
		public function out():void
		{
			_format.color = 0x000000;
			
			bg.alpha = .4;
			M4Tween.to( bg, .25, { alpha: 0 } );
		}
		
		public function dispose():void
		{
			_format = null;
			M4Tween.killTweensOf( bg );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}