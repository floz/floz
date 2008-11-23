
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Tab extends Sprite 
	{
		public static const TAB_OVER:String = "tab_over";
		public static const TAB_OUT:String = "tab_out";
		public static const TAB_PRESS:String = "tab_press";
		
		public var activated:Boolean;
		
		private var status:String = "out";
		
		private var voile:Shape;
		private var menu:Menu;
		
		public function Tab( name:String, activated:Boolean = false ) 
		{
			this.name = name;
			this.activated = activated;
			
			this.buttonMode = true;
			
			var g:Graphics = this.graphics;
			g.lineStyle( 2, 0xffffff, 1, true );
			g.drawRect( 0, 0, 80, 30 );
			g.endFill();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			var cnt:Sprite = new Sprite();
			
			var font:Font = new Myriad();
			var format:TextFormat = new TextFormat( font.fontName, 14, 0xffffff );
			format.align = TextFormatAlign.CENTER;
			
			var text:TextField = new TextField();
			text.width = 80;
			text.multiline = true;
			text.wordWrap = true;
			text.embedFonts = true;
			text.antiAliasType = AntiAliasType.ADVANCED;
			text.autoSize = TextFieldAutoSize.LEFT;
			text.text = this.name.toUpperCase();
			text.setTextFormat( format );
			cnt.addChild( text );
			
			var bd:BitmapData = new BitmapData( 80, 30, true, 0x00 );
			bd.draw( cnt, new Matrix( 1, 0, 0, 1, this.width / 2 - cnt.width / 2 - 1, this.height / 2 - cnt.height / 2 - 1 ) );
			addChild( new Bitmap( bd ) );
			
			voile = new Shape();
			var g:Graphics = voile.graphics;
			g.beginFill( 0xffffff, 1 );
			g.drawRect( 0, 0, 80, 30 );
			g.endFill();
			addChild( voile );
			
			voile.alpha = activated ? .20 : 0;
			
			menu = getAncestor( this, Menu ) as Menu;
			menu.addEventListener( Event.SELECT, onSelect );
			
			parent.addEventListener( Event.SELECT, onSelect );
		}
		
		private function onSelect(e:Event):void 
		{
			activated = ( e.currentTarget.selected == this ) ? true : false;
			
			if ( !activated ) voile.alpha = 0;
		}
		
		// PRIVATE
		
		private function getAncestor( child:DisplayObject, type:* ):*
		{
			var c:DisplayObject = child;
			
			while ( c.parent )
			{
				if ( c.parent is type ) return c.parent;
				c = c.parent;
			}
			
			return null;
		}
		
		// PUBLIC
		
		public function over():void
		{
			status = "over";
			
			voile.alpha = .20;
			dispatchEvent( new Event( Tab.TAB_OVER, true ) );
		}
		
		public function out():void
		{
			status = "out";
			
			if ( !activated ) voile.alpha = 0;
			dispatchEvent( new Event( Tab.TAB_OUT, true ) );
		}
		
		public function down():void
		{
			voile.alpha = .40;
		}
		
		public function up():void
		{
			voile.alpha = ( status == "over" ) || activated ? .20 : 0;
			dispatchEvent( new Event( Tab.TAB_PRESS, true ) );
		}
		
	}
	
}