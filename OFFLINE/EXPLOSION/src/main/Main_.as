
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import fr.minuit4.animation.rain.Rain;
	import fr.minuit4.animation.rain.RainBack;
	import fr.minuit4.utils.debug.FPS;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _rains:Array;
		private var _idx:int;
		private var _inited:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			var b1:Bitmap = new Bitmap( new Ico1( 0, 0 ), PixelSnapping.AUTO, true );
			var b2:Bitmap = new Bitmap( new Ico2( 0, 0 ), PixelSnapping.AUTO, true );
			var b3:Bitmap = new Bitmap( new Ico3( 0, 0 ), PixelSnapping.AUTO, true );
			
			_rains = [ 
						{ instance: null, b: b1, state: 0 },
						{ instance: null, b: b2, state: 0 },
						{ instance: null, b: b3, state: 0 }
					 ];
			
			next( null );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function next( e:Event ):void
		{
			if ( e ) e.currentTarget.removeEventListener( Event.COMPLETE, next );
			
			var r:DisplayObject;
			var o:Object = _rains[ _idx ];
			r = o.state ? new Rain( o.b ) : new RainBack( o.b );
			r.x = r.width * _idx + 50 * _idx + 120;
			r.y = 20;
			if ( _inited ) cnt.removeChild( o.instance );
			cnt.addChild( r );
			
			if ( o.instance && o.instance is Rain )
			{
				( o.instance as Rain ).kill();
				( o.instance as Rain ).eraseBitmap();				
			}
			else if ( o.instance && o.instance is RainBack )
			{
				( o.instance as RainBack ).kill();
				( o.instance as RainBack ).eraseBitmap();
			}
			
			o.instance = r;
			if ( cnt.numChildren == _rains.length && !_inited ) _inited = true;
			
			o.state = o.state == 0 ? 1 : 0;
			
			_idx = _idx < _rains.length - 1 ? _idx + 1 : 0;
			
			if ( r is Rain ) ( r as Rain ).start();
			else ( r as RainBack ).start();
			
			r.addEventListener( Event.COMPLETE, next );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}