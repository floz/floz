package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Main extends Sprite 
	{
		private var phase:int;
		private var event:Event = new Event( Event.COMPLETE );
		private var array:/*Class2*/Array = [];
		private var _a:Array = [ 5, 2, 3, 5, 2, 1, 3 ];
		private var _v:Vector.<int> = Vector.<int>( [ 5, 2, 3, 5, 2, 1, 3 ] );
		
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
				trace( "const" );
			}
			else if ( phase == 1 )
			{
				f = ipp;
				trace( "var" );
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
			const machin:Number = 0;
		}
		
		private function ipp():void
		{
			var machin:Number = 0;
		}
	}
	
}