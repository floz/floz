package fr.minuit4.utils.fp10 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author NICOLAS Arnaud
	 */
	public class SimpleZSorterItem
	{
		private var _item:DisplayObject;
		private var _z:Number;
		
		public function SimpleZSorterItem(pItem:DisplayObject, pZ:Number) 
		{
			_z = pZ;
			_item = pItem;
		}
		
		public function get z():Number { return _z; }
		
		public function get item():DisplayObject { return _item; }
		
	}

}