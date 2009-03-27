
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class PanelLists extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		public static const ITEM_SELECT:String = "item_select";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var list1:ComboBox;
		public var list2:ComboBox;
		public var list3:ComboBox;
		public var list4:ComboBox;
		
		//public var txt1:TextField;
		//public var txt2:TextField;
		//public var txt3:TextField;
		//public var txt4:TextField;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PanelLists() 
		{
			this.y = -this.height;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initList( c:ComboBox, index:int ):void
		{
			var dp:DataProvider = new DataProvider();
			var n:int = Model.datas[ index ].datas.length;
			dp.addItem( { label: Model.datas[ index ].id } )
			for ( var i:int; i < n; ++i )
				dp.addItem( Model.datas[ index ].datas[ i ] );
			
			c.dataProvider = dp;
			
			c.addEventListener( Event.CHANGE, onChange );
		}
		
		private function onChange(e:Event):void 
		{
			if ( ComboBox( e.currentTarget ).selectedItem == Model.currentItem ) return;
			
			Model.currentItem = ComboBox( e.currentTarget ).selectedItem;
			Model.currentListIndex = Model.currentItem.listIndex;
			
			ComboBox( e.currentTarget ).selectedIndex = 0;
			dispatchEvent( new Event( PanelLists.ITEM_SELECT ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{			
			initList( list1, 0 );
			initList( list2, 1 );
			initList( list3, 2 );
			initList( list4, 3 );
			
			TweenLite.to( this, .40, { y: 0, ease: Quad.easeOut } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}