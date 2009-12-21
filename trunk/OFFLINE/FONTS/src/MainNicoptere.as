package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import fr.minuit4.utils.debug.FPS;
	import net.nicoptere.geometry.NaturalCubic;
	import net.nicoptere.geometry.Spline;
	/**
	 * ...
	 * @author nicoptere
	 */
	public class MainNicoptere extends Sprite 
	{
		
		private var nc:NaturalCubic;
		private var controlPoints:Vector.<Point>;
		private var handles:Vector.<Sprite>;
		
		public function MainNicoptere():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			handles = new Vector.<Sprite>();
			controlPoints = new Vector.<Point>();
			
			var p:Point;
			for (var i:int = 0; i<6; i++)
			{
				
				var t:Number = i * 60 * Math.PI / 180;
				
				//p = new Point( 100 + Math.random() * 300, 100 + Math.random() * 300 );
				p = new Point( 	250 + ( 50 + ( Math.random() * 100 ) ) * Math.cos(t),
								250 + ( 50 + Math.random()*100 ) * Math.sin(t) );
				controlPoints.push( p );
				
				//handles
				var handle:Sprite = new Sprite();
				if ( i == 0 )
				{
					handle.graphics.lineStyle( 2,0xFFCC00 );
				}
				else if ( i == 5 )
				{
					handle.graphics.lineStyle( 2, 0xFF0000 );
				}
				
				handle.graphics.beginFill( 0xDDDDDD, .5 );
				handle.graphics.drawCircle( 0, 0, 7 );
				handle.x = p.x;
				handle.y = p.y;
				handle.buttonMode = true;
				
				handle.addEventListener( MouseEvent.MOUSE_DOWN, function (e:Event):void { e.target.startDrag(); addEventListener( Event.ENTER_FRAME, render ); } );
				handle.addEventListener( MouseEvent.MOUSE_UP, function (e:Event):void { stopDrag(); removeEventListener( Event.ENTER_FRAME, render );render();  } );
				
				addChild( handle );
				
				handles.push( handle );
				
			}
			
			addChild( new FPS() );
			
			//renders once
			nc = new NaturalCubic( controlPoints, true );
			render( );
			
		}
		
		private function render( e:Event = null ):void
		{
			
			var p:Point;
			var pts:Vector.<Point>;
			
			controlPoints = new Vector.<Point>();
			for each( var h:Sprite in handles )
			{
				controlPoints.push(  new Point( h.x, h.y ) );
			}
			nc.controlPoints = controlPoints;
			
			this.graphics.clear()
			
			
			this.graphics.lineStyle( 0, 0x00FF00 );
			nc.closed = true;
			nc.steps = 50;
			nc.paint( this.graphics );
			
			
			this.graphics.lineStyle( 0, 0xFFCC00 );
			nc.closed = true;
			nc.steps = 30;
			nc.paint( this.graphics );
			pts = nc.curveAsPoints;
			for each( p in pts )graphics.drawCircle( p.x, p.y, 2 );
			
			
			//former Spline version
			//pts = Spline.CubicPath( controlPoints, false, .1 )
			//graphics.lineStyle(0, 0xCC3300 );
			//graphics.moveTo( pts[0].x, pts[0].y );
			//var i:int = -1;
			//while ( i++ < pts.length-1 )
			//{
				//graphics.lineTo( pts[i].x,pts[i].y );
			//}
			//
			//pts = Spline.CubicPath( controlPoints, true, .1 )
			//graphics.lineStyle(0, 0xCC3300 );
			//graphics.moveTo( pts[0].x, pts[0].y );
			//i = -1;
			//while ( i++ < pts.length-1 )
			//{
				//graphics.lineTo( pts[i].x,pts[i].y );
			//}
			
		}
		
	}
	
}