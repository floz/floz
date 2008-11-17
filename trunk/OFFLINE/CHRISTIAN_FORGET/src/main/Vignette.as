
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class Vignette extends Sprite 
	{
		public var preview:String;
		public var film:String;
		private var voile:Shape;
		
		public function Vignette( name:String, preview:String, film:String )
		{
			this.name = name;
			this.preview = preview;
			this.film = film;
			
			var g:Graphics = this.graphics;
			g.lineStyle( 2, 0xffffff, 1, true );
			g.drawRect( 0, 0, 125, 35 );
			g.endFill();
			
			voile = new Shape();
			g = voile.graphics;
			g.beginFill( 0xffffff, 1 );
			g.drawRect( 0, 0, 125, 35 );
			g.endFill();
			addChild( voile );
			
			voile.alpha = 0;
		}
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
		
		public function over():void
		{
			voile.alpha = .20;
		}
		
		public function out():void
		{
			voile.alpha = 0;
		}
		
		public function down():void
		{
			
		}
		
		public function up():void
		{
			
		}
		
	}
	
}