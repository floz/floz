
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	import com.as3dmod.core.Modifier;
	import com.as3dmod.modifiers.Bend;
	import com.as3dmod.modifiers.Perlin;
	import com.as3dmod.modifiers.Pivot;
	import com.as3dmod.modifiers.Taper;
	import com.as3dmod.modifiers.Twist;
	import fl.controls.Button;
	import fl.controls.List;
	import flash.display.Sprite;
	import flash.events.Event;
	import fl.data.DataProvider;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class PartsInfos extends Sprite
	{
		public static const ADD_CLICK:String = "add_click";
		public static const DELETE_CLICK:String = "delete_click";
		public static const PART_CHANGE:String = "part_change";
		public static const ATTRIBUTE_SELECT:String = "attribute_select";
		
		public var listParts:List;
		public var listAttributes:List;
		public var txtAttributes:TextField;
		public var zAdd:Button;
		public var zDelete:Button;
		
		private var inited:Boolean;
		private var currentPart:Object;
		private var currentAttribute:Object;
		
		public function PartsInfos() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			zAdd.visible = false;
			zDelete.visible = false;
			
			var dp:DataProvider = new DataProvider();
			var n:int = Model.listParts.length;
			for ( var i:int; i < n; i++ )
				dp.addItem( Model.listParts[ i ] );
			
			listParts.dataProvider = dp;
			
			txtAttributes.text = "Aucune partie du corps n'a été sélectionnée.";
			
			listParts.addEventListener( Event.CHANGE, onPartChange );
			listAttributes.addEventListener( Event.CHANGE, onAttributeChange );
			zAdd.addEventListener( MouseEvent.CLICK, onMouseClick );
			zDelete.addEventListener( MouseEvent.CLICK, onMouseClick );
		}
		
		private function onPartChange(e:Event):void 
		{
			if ( !inited ) 
			{
				zAdd.visible = true;
				inited = true;
			}
			
			currentPart = e.currentTarget.selectedItem;
			Model.currentPart = currentPart;
			refreshListAttributes();
			
			zDelete.visible = false;
			
			dispatchEvent( new Event( PartsInfos.PART_CHANGE ) );
		}
		
		private function onAttributeChange(e:Event):void 
		{
			currentAttribute = e.currentTarget.selectedItem;
			Model.currentAttribute = currentAttribute;
			if ( !zDelete.visible ) zDelete.visible = true;
			
			dispatchEvent( new Event( PartsInfos.ATTRIBUTE_SELECT ) );
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case zAdd: openAddPanel(); break;
				case zDelete: deletionProcedure(); break;
			}
		}
		
		// PRIVATE
		
		private function openAddPanel():void
		{
			dispatchEvent( new Event( PartsInfos.ADD_CLICK ) );
		}
		
		private function deletionProcedure():void
		{
			dispatchEvent( new Event( PartsInfos.DELETE_CLICK ) );	
		}
		
		// PUBLIC
		
		public function addAttribute( type:String, name:String ):void
		{
			var m:Modifier;
			switch( type )
			{
				case "Bend": m = new Bend( 0, 0, 0 ); break;
				case "Perlin": m = new Perlin( 0 ); break;
				case "Pivot": m = new Pivot(); break;
				case "Twist": m = new Twist( 0 ); break;
			}
			
			currentPart.attributes.push( { label: name, data: currentPart.attributes.length, modifier: m } );
			refreshListAttributes();			
		}
		
		public function deleteCurrentAttribute():void
		{
			currentPart.attributes.splice( currentAttribute.data, 1 );
			refreshListAttributes();
		}
		
		public function refreshListAttributes( saveSelection:Boolean = false ):void
		{
			var idxSelection:int;
			if ( saveSelection ) idxSelection = listAttributes.selectedIndex;
			
			var list:Array = currentPart.attributes;
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
			
			if ( saveSelection ) 
			{
				listAttributes.selectedIndex = idxSelection;
				return;
			}
			
			currentAttribute = null;
			zDelete.visible = false;
		}
		
		// GETTERS & SETTERS
		
		public function getCurrentAttribute():Object { return this.currentAttribute; }
		
	}
	
}