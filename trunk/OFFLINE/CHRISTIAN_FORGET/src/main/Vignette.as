
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
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
	
	public class Vignette extends Sprite 
	{
		public static const VIGNETTE_OVER:String = "vignette_over";
		public static const VIGNETTE_OUT:String = "vignette_out";
		public static const VIGNETTE_PRESS:String = "vignette_press";
		
		private var status:String = "out";
		
		public var preview:String;
		public var film:String;
		public var director:String;
		public var production:String;
		public var postProduction:String;
		private var voile:Shape;
		
		public function Vignette( name:String, preview:String, film:String, director:String, production:String, postProduction:String )
		{
			this.name = name;
			this.preview = preview;
			this.film = film;
			this.director = director;
			this.production = production;
			this.postProduction = postProduction;
			
			var g:Graphics = this.graphics;
			g.lineStyle( 2, 0xffffff, 1, true );
			g.drawRect( 0, 0, 125, 35 );
			g.endFill();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			var cnt:Sprite = new Sprite();
			
			var font:Font = new Myriad();
			var format:TextFormat = new TextFormat( font.fontName, 12, 0xffffff );
			format.align = TextFormatAlign.CENTER;
			
			var text:TextField = new TextField();
			text.width = 125;
			text.multiline = true;
			text.wordWrap = true;
			text.embedFonts = true;
			text.antiAliasType = AntiAliasType.ADVANCED;
			text.autoSize = TextFieldAutoSize.LEFT;
			text.text = this.name.toUpperCase();
			text.setTextFormat( format );
			cnt.addChild( text );
			
			var bd:BitmapData = new BitmapData( 125, 35, true, 0x00 );
			bd.draw( cnt, new Matrix( 1, 0, 0, 1, 0, this.height / 2 - cnt.height / 2 - 1 ) );
			addChild( new Bitmap( bd ) );
			
			voile = new Shape();
			var g:Graphics = voile.graphics;
			g.beginFill( 0xffffff, 1 );
			g.drawRect( 0, 0, 125, 35 );
			g.endFill();
			addChild( voile );
			
			voile.alpha = 0;
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function over():void
		{
			status = "over";
			
			voile.alpha = .20;
			dispatchEvent( new Event( Vignette.VIGNETTE_OVER, true ) );
		}
		
		public function out():void
		{
			status = "out";
			
			voile.alpha = 0;
			dispatchEvent( new Event( Vignette.VIGNETTE_OUT, true ) );
		}
		
		public function down():void
		{
			voile.alpha = .40
		}
		
		public function up():void
		{
			voile.alpha = status == "over" ? .20 : 0;
			dispatchEvent( new Event( Vignette.VIGNETTE_PRESS, true ) );
		}
		
		public function get infos():Object { return { name: this.name, preview: this.preview, film: this.film } };
		
	}
	
}