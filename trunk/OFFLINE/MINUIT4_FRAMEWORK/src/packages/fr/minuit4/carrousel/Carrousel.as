/**
 * @author 			Arno NICOLAS
 * @version 		0.1
 * Date				Février 2009
 * Description		Carrousel en ActionScript 3.0 sans utilisation d'API 3D (FlashPlayer 10 ou library OpenSource Pv3D ou autre)
 * @example
 * 
 * 		import fr.minuit4.carrousel.Carrousel;
 * 
 * 		var c:Carrousel = new Carrousel();
 * 		c.x = stage.stageWidth * .5;
 * 		c.y = stage.stageHeight * .5;
 * 		this.addChild(c);
 * 		var i:int;
 * 		for (i = 0; i < _max; i++)
 * 			c.addItem();
 * 		c.launch();
 * 
 */
package fr.minuit4.carrousel 
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Carrousel extends Sprite
	{
		
		private var _library:Array = [];
		private var _maxItem:int;
		private var _angle:Number = 90;
		private var _rayonX:int = 200;
		private var _rayonY:int = -50;
		private var _hasReflect:Boolean;
		
		
		/**
		 * Constructor
		 * @param	pLibrary:Array			Paramètre optionnel - tableau à une dimension contenant les DisplayObject qu'on souhaite ajouter au carroussel
		 * @param	pHasRelfect:Booleaan	Paramètre optionnel - indique si on souhaite ajouter un reflet aux items
		 */
		public function Carrousel(pLibrary:Array = null, pHasReflect:Boolean = true ) 
		{
			if (pLibrary)
			{
				var m:int = pLibrary.length;
				var i:int;
				for (i = 0; i < m; i++)
					this.addItem(pLibrary[i]);
			}
			_hasReflect = pHasReflect;
		}
		
		
		/**
		 * Public méthode de démarrage du carroussel
		 * Initialisation des positions des Items du carroussel
		 */
		public function launch():void
		{
			_maxItem = _library.length;
			var i:int;
			for (i = 0; i < _maxItem; i++)
			{
				var s:Item = _library[i];
				var r:Number = _angle + (360 / (_maxItem)) * i;
				var a:Number = (r) * (Math.PI / 180);
				s.x = Math.cos(a) * _rayonX;
				s.y = Math.sin(a) * _rayonY;
				s.angle = r;		
			}
			this.render();
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		
		/**
		 * Public méthode d'ajout d'un nouvel item au carroussel
		 * @param	pDisplayObject:DisplayObject		DisplayObject qu'on souhaite voir affiché - seule contrainte : qu'il soit aligné sur son angle haut gauche. L'item se centrera automatiquement.
		 * @return :Item
		 */
		public function addItem(pDisplayObject:DisplayObject = null):Item
		{
			var i:Item = new Item(pDisplayObject, _hasReflect);
			this.addChild(i);
			_library.push(i);
			return i;
		}
		
		
		/**
		 * Private méthode appelée lors de l'évènement ENTER_FRAME actualisant la position de chaque Item du carroussel en fonction de la position de la souris
		 * @param	e:Event		Event.ENTER_FRAME
		 */
		private function onFrame(e:Event):void 
		{
			var i:int;
			for (i = 0; i < _maxItem; i++)
			{
				var s:Item = this.getChildAt(i) as Item;
				var difX:Number =  (this.mouseX) * .05;
				s.angle += difX;
				if (s.angle > 360)
					s.angle = s.angle - 360;
				else if (s.angle <= 0)
					s.angle = 360 + s.angle;
				var a:Number = s.angle * (Math.PI / 180);
				s.x = Math.cos(a) * _rayonX;
				s.y = Math.sin(a) * _rayonY;
			}
			render();			
		}
		
		
		/**
		 * Private méthode de rendu du carroussel 
		 * Actualisation de la profondeur des Items en fonction des angles
		 */
		private function render():void
		{
			var i:int;
			var t:Array = [];
			_library.sortOn("angle", Array.DESCENDING | Array.NUMERIC);
			for (i = 0; i < _maxItem; i++)
				t[i] = {"angle":Math.sin(_library[i].angle/(180/Math.PI))*50, "target":_library[i]};
			t.sortOn("angle", Array.DESCENDING | Array.NUMERIC);
			for (i = 0; i < _maxItem; i++)
			{
				var p:DisplayObject = t[i].target;
				p.scaleX = (100 - (length - i)) / 100;
				p.scaleY = p.scaleX;
				p.alpha = p.scaleX;
				this.setChildIndex(p, i);
			}			
		}
		
		
		/**
		 * Public méthode d'ajout d'items au carrousel
		 * @param	pItems:Array		Tableau de displayObject
		 */
		public function addItems(pItems:Array):void
		{
			_library.concat(pItems);
		}
		
		/**
		 * GETTER --- SETTER 
		 */
		 
		public function get rayonX():int { return _rayonX; }
		
		public function set rayonX(value:int):void 
		{
			_rayonX = value;
		}
		
		public function get rayonY():int { return _rayonY; }
		
		public function set rayonY(value:int):void 
		{
			_rayonY = value;
		}
		
		public function get hasReflect():Boolean { return _hasReflect; }
	}
	
}