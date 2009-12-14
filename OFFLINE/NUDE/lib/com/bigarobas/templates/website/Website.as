package com.bigarobas.templates.website {
	import com.bigarobas.templates.Main;
	import com.bigarobas.templates.MainEvent;
	import com.bigarobas.utils.command.CommandDefinition;
	import com.bigarobas.utils.debug.Debugger;
	import com.bigarobas.utils.deeplinking.*;
	
	public class Website extends Main {

		
		protected var _sitename:String;
		protected var _address:String;
		protected var _addressArray:Array;
		
		public function Website() {
			addEventListener(MainEvent.BUILT, onBuilt);
		}
		
		override protected function initTemplate():void {
			
			shell.dictionary.add(new CommandDefinition("gotopage", function (a:Array):void { resolvePage(a[0]); }, "goto website page | params -> pagedeeplink:String | use -> gotopage,/second/;") );
			
			if (flashvars.sitename) _sitename = flashvars.sitename;
			else _sitename = "Default site name (you can change it in 'index.html' flashvars->sitename)";			
			
		}
		
		private function onBuilt(e:MainEvent):void {
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onSWFAddressChange);
		}
		
		protected function onSWFAddressChange(e:SWFAddressEvent):void {
			
			_address = e.value;
			_addressArray = SWFAddressParser.addressToArray(_address);
			
			resolvePage(_address);
			
			var tTitle:String = _sitename;	
			for (var i:int = 0; i < e.pathNames.length; i++) {
				tTitle += ' / ' + e.pathNames[i].substr(0,1).toUpperCase() + e.pathNames[i].substr(1);
			}
			
			SWFAddress.setTitle(tTitle);
		}
		
		protected static function gotoPage(vPage:String = "/"):void {
			SWFAddress.setValue(vPage);			
		}
		
		// to be overriden by your own website
		protected function resolvePage(vPage:String):void {
			debugger.print(this, "GOTO PAGE", vPage);
		}
		
		public function get address():String { return _address; }
		
		public function set address(value:String):void {
			_address = value;
			_addressArray = SWFAddressParser.addressToArray(_address);
			gotoPage(_address);
		}
		
		public function get addressArray():Array { return _addressArray; }
		
		public function set addressArray(value:Array):void {
			_addressArray = value;
			address = SWFAddressParser.arrayToAddress(_addressArray);
		}
		
	}
	
}