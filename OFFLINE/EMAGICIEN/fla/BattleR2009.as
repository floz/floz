package 
{
	
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Pjetr
	 */
	public class BattleR2009 extends MovieClip 
	{
		private var voisin:Loader;
		//private var balcon:Loader;
		private var adresse:URLRequest = new URLRequest();
		private var timer:Timer = new Timer(30000, 0);
		private var open:String = "";
		public var test:String = "tetten";
		public var focusVoisin:Loader;
		
		public function BattleR2009() {
			init();	
		}
		private function init() {
			// -----------------------------------------------------------
			// ---------- Initialisation Propriétés
			//-----------------------------------------------------------
			neon.mouseChildren = false;
			neon.mouseEnabled = false;
			
			// -----------------------------------------------------------
			// ---------- Chargement des appartements
			//-----------------------------------------------------------
			
			for (var i:int = 1;i<=13;i++) {
				voisin = new Loader();
				adresse.url = "Team" + i + ".swf";
				voisin.load(adresse);
				addChild(voisin);
				voisin.name = "Team" + i + ".swf";
				voisin.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );
				voisin.addEventListener(MouseEvent.MOUSE_DOWN, premierPlan);
			}
			
			// -----------------------------------------------------------
			// ---------- Chargement Balcons
			//-----------------------------------------------------------
			//
			//balcon = new Loader();
			//adresse.url = "Medias/balcons.png";
			//balcon.load(adresse);
			//addChild(balcon);
			//balcon.mouseEnabled = false;
			// -----------------------------------------------------------
			// ---------- Clignotement Néon
			//-----------------------------------------------------------

			timer.addEventListener(TimerEvent.TIMER, clignoter);			
			timer.start();

			// -----------------------------------------------------------
			// ---------- Choix plans
			//-----------------------------------------------------------

			setChildIndex(neon, numChildren - 1);
			//setChildIndex(balcon, numChildren - 1);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void 
		{
			trace("BattleR2009.ioErrorHandler > e : " + e);
			
		}
		private function premierPlan(e:MouseEvent) {
			trace("open : " + open);
			var clickedName:String = e.currentTarget.name;		
			if (open == clickedName) {
				trace("dispatch");
				dispatchEvent(new Event("DeInit"));
				for (var i:int=1; i < 14; i++) {
					var test = getChildByName("Team" + i + ".swf");
					var temp:DisplayObject;
					if (test.hitTestPoint(mouseX, mouseY, false) && test.name != open) {
						showLoader(test);
						focusVoisin = test;
						trace(">>>", focusVoisin.name);
						focusVoisin.content.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
					}
				}
				open = focusVoisin.name;
			}else {
				dispatchEvent(new Event("DeInit"));
				
				
				showLoader(DisplayObject(e.currentTarget));
				focusVoisin = Loader(e.currentTarget);
				//focusVoisin.content.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				open = clickedName;
				trace("open : " + open);
			}
			//(focusVoisin as Loader).content.dispatchEvent(new Event("Open", true, true));
		}
		
		private function showLoader(d:DisplayObject):void
		{
			setChildIndex(d, numChildren - 1);
			setChildIndex(neon, numChildren - 1);
			//setChildIndex(balcon, numChildren - 1);
		}
		private function clignoter (e:TimerEvent) {
			neon.play();	
		}
	}
	
}