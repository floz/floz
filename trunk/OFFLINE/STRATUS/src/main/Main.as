
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import fr.minuit4.net.stratus.StratusConnection;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _field:TextField;
		private var _stratusConnection:StratusConnection;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			initInterface();
			
			_stratusConnection = new StratusConnection( "76418ac5f3689170bce4fbed-d76819ed40c7" );
			_stratusConnection.addEventListener( StratusConnection.CONNECT, onStratusConnect );
			_stratusConnection.connect();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function link(e:MouseEvent):void 
		{
			_stratusConnection.addUserToListen( _field.text );
		}
		
		private function send(e:MouseEvent):void
		{
			_stratusConnection.send( "essai", "try" );
		}
		
		private function onStratusConnect(e:Event):void 
		{
			trace( "connection : " + _stratusConnection.userId );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initInterface():void
		{
			_field = new TextField();
			_field.type = TextFieldType.INPUT;
			_field.width = 400;
			_field.height = 20;
			_field.border = true;
			_field.borderColor = 0xff00ff;
			addChild( _field );
			
			var s1:Sprite = createSquare( 0xff00ff );
			s1.x = _field.width + _field.x + 20;
			addChild( s1 );
			
			var s2:Sprite = createSquare( 0x00ff00 );
			s2.x = _field.width + _field.x + 20;
			s2.y = s1.y + 45;
			addChild( s2 );
			
			_field.y = 
			_field.x =
			s1.y = 10;
			
			s1.addEventListener( MouseEvent.CLICK, link );
			s2.addEventListener( MouseEvent.CLICK, send );
		}
		
		private function createSquare( color:uint ):Sprite
		{
			var s:Sprite = new Sprite();
			var g:Graphics = s.graphics;
			g.beginFill( color );
			g.drawRect( 0, 0, 20, 20 );
			g.endFill();
			
			return s;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}