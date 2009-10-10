package 
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
				trace( "externe class" );
			}
			else if ( phase == 1 )
			{
				f = ipp;
				trace( "inside class" );
			}		
			
			var debut:Number = 0;
			var compteur:int;
			for ( var i:int; i < 1000; i++ )
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
			var n:int = 1000;
			for ( j = 0; j < n; ++j )
			{
				new NewClass();
			}
		}
		
		private function ipp():void
		{
			var b:Boolean;
			
			var j:int;
			var n:int = 1000;
			for ( j = 0; j < n; ++j )
			{
				new InsideClass();
			}
		}
		
	}
	
}

final class InsideClass
{
	public function InsideClass()
	{
		
	}
}