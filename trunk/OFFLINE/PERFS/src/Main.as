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
		private var event:Event = new Event( Event.COMPLETE );
		private var array:/*Class2*/Array = [];
		
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
				trace( "concat" );
			}
			else if ( phase == 1 )
			{
				f = ipp;
				trace( "push" );
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
			var v1:Vector.<Sprite> = new Vector.<Sprite>();
			v1[ 0 ] = new Sprite();
			v1[ 1 ] = new Sprite();
			v1[ 2 ] = new Sprite();
			
			var v2:Vector.<Sprite> = new Vector.<Sprite>();
			v2[ 0 ] = new Sprite();
			v2[ 1 ] = new Sprite();
			
			var j:int, n:int = v2.length;
			for ( var i:int; i < 100; ++i )
			{
				for ( j = 0; j < n; ++j )
					v1.push( v2[ j ] );
			}
		}
		
		private function ipp():void
		{
			var v1:Vector.<Sprite> = new Vector.<Sprite>();
			v1[ 0 ] = new Sprite();
			v1[ 1 ] = new Sprite();
			v1[ 2 ] = new Sprite();
			
			var v2:Vector.<Sprite> = new Vector.<Sprite>();
			v2[ 0 ] = new Sprite();
			v2[ 1 ] = new Sprite();
			
			var j:int, n:int = v2.length;
			for ( var i:uint; i < 100; ++i )
			{
				for ( j = 0; j < n; ++j )
					v1.push( v2[ j ] );
			}
		}
		
	}
	
}