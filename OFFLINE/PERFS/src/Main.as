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
		
		public function Main():void 
		{
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick( e:Event ):void
		{
			var f:Function;
			if ( phase == 0 ) 
			{
				f = ppi;
				trace( "++i" );
			}
			else if ( phase == 1 )
			{
				f = ipp;
				trace( "i++" );
			}
			else
			{
				f = ipeu;
				trace( "i+=1" );
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
			
			phase = phase == 2 ? phase = 0 : phase + 1;
		}
		
		private function ppi():void
		{
			var j:int;
			for ( j = 0; j < 10000; ++j )
			{
			}
		}
		
		private function ipp():void
		{
			var j:int;
			for ( j = 0; j < 10000; j++ )
			{
			}
		}
		
		private function ipeu():void
		{
			var j:int;
			for ( j = 0; j < 10000; j+=1 )
			{
			}
		}
		
	}
	
}