
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Main extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var masksPanel:MasksPanel;
		public var controlPanel:ControlPanel;
		public var settingsPanel:SettingsPanel;
		public var loadingPanel:LoadingPanel;
		public var beatlizer:Beatlizer;
		public var form:Form;
		public var curtain:MovieClip;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			Model.PATH_PHP = path_php;
			Model.enable = true;
			
			curtain.visible = false;
			curtain.alpha = 0;
			
			form.visible = false;
			
			controlPanel.addEventListener( ControlPanel.UPLOAD, onUpload );
			controlPanel.addEventListener( ControlPanel.VALID_BEATLES, onValidBeatles );
			
			loadingPanel.addEventListener( Event.CANCEL, onCancel );
			loadingPanel.addEventListener( Event.COMPLETE, onLoadComplete );
			
			masksPanel.addEventListener( MasksPanel.MASK_SELECTED, onMaskSelected );
			
			settingsPanel.addEventListener( SettingsPanel.VALUE_CHANGE, onValueChange );
			
			form.addEventListener( Form.STEP_BACK, onStepBack );
			form.addEventListener( Form.END, onEnd );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onUpload(e:Event):void 
		{
			curtain.visible = true;
			curtain.alpha = 0;
			TweenLite.to( curtain, .4, { alpha: .8, ease: Quad.easeOut } );
			
			Model.enable = false;
			loadingPanel.upload();
		}
		
		private function onValidBeatles(e:Event):void 
		{
			form.display();
			
			curtain.visible = true;
			curtain.alpha = 0;
			TweenLite.to( curtain, .4, { alpha: .8, ease: Quad.easeOut } );
		}
		
		private function onCancel(e:Event = null):void 
		{
			TweenLite.to( curtain, .4, { alpha: 0, ease: Quad.easeOut, onComplete: killCurtain } );
		}
		
		private function onLoadComplete(e:Event):void 
		{
			if ( !Model.initialized )
			{				
				controlPanel.init();
				masksPanel.init();
				settingsPanel.init();
				beatlizer.setMask();
				
				Model.initialized = true;
			}
			settingsPanel.resetSaturation();
			beatlizer.setPhoto();
		}
		
		private function onMaskSelected(e:Event):void 
		{
			beatlizer.setMask();
		}
		
		private function onValueChange(e:Event):void 
		{
			beatlizer.setPhotoSaturation();
			beatlizer.setPhotoScale();
			beatlizer.setRotation();
		}
		
		private function onStepBack(e:Event):void 
		{
			form.hide();
			onCancel();
		}
		
		private function onEnd(e:Event):void 
		{
			trace( "this is the end" );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function killCurtain():void
		{
			curtain.visible = false;
			curtain.alpha = 0;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_php():String { return loaderInfo.parameters[ "path_php" ] || "http://localhost/BEATLIZER/bin/assets/php/"; }
		
	}
	
}