package fr.minuit4.tools.carrousel3D
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author NICOLAS Arnaud
	 */
	public class Carrousel3D extends Sprite
	{
		private var _listItem:Vector.<DisplayObject>;
		private var _rayon:int = 200;
		
		public function Carrousel3D() 
		{
			_listItem = new Vector.<DisplayObject>();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function addItem(pItem:DisplayObject):DisplayObject
		{
			var s:Sprite = new Sprite();
			s.addChild(pItem);
			pItem.x = -pItem.width >> 1;
			pItem.y = -pItem.height;
			_listItem.push(s);
			this.update();
			return s;
		}
		
		private function update():void
		{
			var i:int;
			var ecart:Number = 360 / _listItem.length;
			for (i = 0; i < _listItem.length; ++i)
			{
				var d:DisplayObject = _listItem[i] as DisplayObject;
				var r:Number = (ecart*i) * (Math.PI / 180);
				d.x = Math.cos(r) * _rayon;
				d.z = Math.sin(r) * _rayon;
				this.addChild(d);
				d.rotationY = -(ecart*i) - 90;
			}
		}
		
	}
	
}