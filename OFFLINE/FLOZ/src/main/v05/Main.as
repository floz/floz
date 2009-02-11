
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	import com.as3dmod.modifiers.Bend;
	import com.as3dmod.modifiers.Perlin;
	import com.as3dmod.modifiers.Taper;
	import com.as3dmod.modifiers.Twist;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		public var partsInfos:PartsInfos;
		public var confirmation:Confirmation;
		public var settingsController:SettingsController;
		
		public function Main() 
		{
			var n:int = Model.listParts.length;
			for ( var i:int; i < n; i++ )
				Model.listAttributes[ Model.listParts[ i ].label ] = [];
			
			partsInfos.addEventListener( PartsInfos.ADD_CLICK, onAddClick );
			partsInfos.addEventListener( PartsInfos.DELETE_CLICK, onDeleteClick );
			partsInfos.addEventListener( PartsInfos.PART_CHANGE, onPartChange );
			partsInfos.addEventListener( PartsInfos.ATTRIBUTE_SELECT, onAttributeSelect );
			confirmation.addEventListener( Confirmation.CONFIRM, onConfirm );
		}
		
		// EVENTS
		
		private function onAddClick(e:Event):void 
		{
			confirmation.openAddPanel();
		}
		
		private function onDeleteClick(e:Event):void 
		{
			confirmation.openDeletePanel();
		}
		
		private function onPartChange(e:Event):void 
		{
			settingsController.hideAll();
		}
		
		private function onAttributeSelect(e:Event):void 
		{
			if ( partsInfos.getCurrentAttribute().modifier is Bend ) settingsController.showBendSettings( partsInfos.getCurrentAttribute() );
			else if ( partsInfos.getCurrentAttribute().modifier is Perlin ) trace ("perlin" );
			else if ( partsInfos.getCurrentAttribute().modifier is Taper ) trace ("taper" );
			else if ( partsInfos.getCurrentAttribute().modifier is Twist ) trace ("twist" );
		}
		
		private function onConfirm(e:Event):void 
		{
			if ( confirmation.currentLabel == "Add" )
			{
				partsInfos.addAttribute( e.currentTarget.selected, e.currentTarget.selectedName );
			}
			else
			{
				partsInfos.deleteCurrentAttribute();
			}			
			settingsController.hideAll();
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}