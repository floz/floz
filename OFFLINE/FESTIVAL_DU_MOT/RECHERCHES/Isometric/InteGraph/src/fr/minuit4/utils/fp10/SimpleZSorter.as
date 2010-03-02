package fr.minuit4.utils.fp10
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.geom.Matrix3D;
	
	/**
	 * ...
	 * @author NICOLAS Arnaud
	 */
	public class SimpleZSorter
	{
		
		static public function sort(pContainer:DisplayObjectContainer):void
		{
			if (!pContainer || !pContainer.numChildren)
				return;
			
			var items:Vector.<SimpleZSorterItem> = new Vector.<SimpleZSorterItem>();
			var i:int = 0;
			var max:int = pContainer.numChildren;
			var matrix:Matrix3D;
			var target:DisplayObject;
			for (; i < max; ++i)
			{
				target =  pContainer.getChildAt(i);
				matrix = target.transform.getRelativeMatrix3D(pContainer.stage);
				items.push(new SimpleZSorterItem(target, matrix.position.z));
			}
			
			matrix = null;
			target = null;
			
			items.sort(SimpleZSorter.compareSimpleZSorterItem);
			
			i = 0;
			for (; i < max; ++i)
				pContainer.setChildIndex(items[i].item, i);
			
			items = null;
		}
		
		static private function compareSimpleZSorterItem(pFirst:SimpleZSorterItem, pSecond:SimpleZSorterItem):Number
		{
			return pSecond.z - pFirst.z;
		}
		
	}

}