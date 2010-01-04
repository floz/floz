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
		
		private var p1:Point = new Point( 234.55, 21 );
		private var p2:Point = new Point( 132.1, 98.3 );
		
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
				trace( "for" );
			}
			else if ( phase == 1 )
			{
				f = ipp;
				trace( "while" );
			}					
			
			var debut:Number = 0;
			var compteur:int;
			for ( var i:int; i < 1000000; i++ )
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
			var v:Vector.<String> = new Vector.<String>( 5, true );
			v[ 0 ] = "tata";
			v[ 1 ] = "azeaz";
			v[ 2 ] = "azezae";
			v[ 3 ] = "taerzerezta";
			v[ 4 ] = "zerz";
			
			var s:String;
			var i:int;
			var n:int = v.length;
			for ( i; i < n; ++i )
			{
				s = v[ i ];
			}
		}
		
		private function ipp():void
		{
			var v:Vector.<String> = new Vector.<String>( 5, true );
			v[ 0 ] = "tata";
			v[ 1 ] = "azeaz";
			v[ 2 ] = "azezae";
			v[ 3 ] = "taerzerezta";
			v[ 4 ] = "zerz";
			
			var s:String;
			var i:int = v.length;
			while ( --i > -1 )
			{
				s = v[ i ];
			}
		}
		
	}
	
}