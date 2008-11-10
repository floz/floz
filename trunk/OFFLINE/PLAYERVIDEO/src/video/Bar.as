
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package video 
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import video.components.Timeline;
	
	public class Bar extends Sprite
	{
		
		public function Bar( p:VideoPlayer03 ) 
		{			
			var g:Graphics;
			
			var background:Shape = new Shape();
			g = background.graphics;
			g.lineStyle( 1, 0x444444 );
			g.drawRect( 0, 0, 205, 10 );
			g.endFill();
			
			background.x = -2.5;
			background.y = -2.5;
			
			var loadedBar:Sprite = new Sprite();
			g = loadedBar.graphics;
			g.beginFill( 0x000000 );
			g.drawRect( 0, 0, 200, 5 );
			g.endFill();
			
			var playedBar:Sprite = new Sprite();
			g = playedBar.graphics;
			g.beginFill( 0x0000FF );
			g.drawRect( 0, 0, 200, 5 );
			g.endFill();
			
			var bar:Sprite = new Sprite();
			bar.addChild( loadedBar );
			bar.addChild( playedBar );
			
			var cursor:MovieClip = new MovieClip();
			g = cursor.graphics;
			g.beginFill( 0xff00ff );
			g.drawRect( 0, 0, 20, 10 );
			g.endFill();
			
			cursor.y = -2.5;
			
			var tl:Timeline = new Timeline( p );
			tl.config( loadedBar, playedBar, bar, cursor, background, true );
			addChild( tl );
			
			tl.x = 50;
			tl.y = 400
		}
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}