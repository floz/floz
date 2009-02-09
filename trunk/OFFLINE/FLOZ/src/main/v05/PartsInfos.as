
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	import fl.controls.Button;
	import fl.controls.List;
	import flash.display.Sprite;
	import flash.events.Event;
	import fl.data.DataProvider;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class PartsInfos extends Sprite
	{
		public var listParts:List;
		public var listAttributes:List;
		public var txtAttributes:TextField;
		public var zAdd:Button;
		public var zDelete:Button;
		
		private var currentPart:Object;
		private var currentAttribute:Object;
		
		public function PartsInfos() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			var dp:DataProvider = new DataProvider();
			var n:int = Model.listParts.length;
			for ( var i:int; i < n; i++ )
				dp.addItem( Model.listParts[ i ] );
			
			listParts.dataProvider = dp;
			
			txtAttributes.text = "Aucune partie du corps n'a été sélectionnée.";
			
			listParts.addEventListener( Event.CHANGE, onPartChange );
			zAdd.addEventListener( MouseEvent.CLICK, onMouseClick );
			zDelete.addEventListener( MouseEvent.CLICK, onMouseClick );
		}
		
		// PRIVATE
		
		private function onPartChange(e:Event):void 
		{
			currentPart = e.currentTarget.selectedItem;
			var list:Array = e.currentTarget.selectedItem.hist;
			if ( !list.length )
			{
				listAttributes.dataProvider = new DataProvider();
				
				txtAttributes.text = "Aucun attribut n'est lié à cette partie.";
				txtAttributes.visible = true;
				return;
			}
			txtAttributes.visible = false;
			
			var dp:DataProvider = new DataProvider();
			var n:int = list.length;
			for ( var i:int; i < n; i++ )
				dp.addItem( list[ i ] );
			
			listAttributes.dataProvider = dp;
		}
		
		// PUBLIC
		
	}
	
}