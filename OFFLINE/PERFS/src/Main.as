﻿package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Main extends Sprite 
	{
		private var phase:int;
		
		private var _list:Dictionary = new Dictionary();
		
		public function Main():void 
		{
			_list[ "test" ] = "toto";
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick( e:Event ):void
		{
			var f:Function;
			if ( phase == 0 ) 
			{
				f = ppi;
				trace( "\"test\" in _list" );
			}
			else if ( phase == 1 )
			{
				f = ipp;
				trace( "_list[ \"test\" ]" );
			}		
			
			var debut:Number = 0;
			var compteur:int;
			for ( var i:int; i < 10000; i++ )
			{
				debut = getTimer();
				f();
				compteur += getTimer() - debut;
			}
			trace ( compteur );
			
			phase = phase == 1 ? phase = 0 : phase + 1;
		}
		
		private function ppi():void
		{
			var b:Boolean;
			
			var j:int;
			var n:int = 10000;
			for ( j = 0; j < n; ++j )
			{
				if( "test" in _list ) {}
			}
		}
		
		private function ipp():void
		{
			var b:Boolean;
			
			var j:int;
			var n:int = 10000;
			for ( j = 0; j < n; ++j )
			{
				if( _list[ "test" ] ) {}
			}
		}
		
	}
	
}