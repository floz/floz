
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gs.easing.Back;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class LinksManager extends Sprite 
	{
		private var links:Array;
		private var request:URLRequest;
		
		public function LinksManager( links:Array ) 
		{
			this.links = links;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage )
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			this.x = 50;
			this.y = 70;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			request = Link( e.currentTarget.parent ).mail ? new URLRequest( "mailTo:" + Link( e.currentTarget.parent ).url ) : new URLRequest( "http://" + Link( e.currentTarget.parent ).url );
			try
			{
				navigateToURL( request, "_blank" );
			}
			catch ( er:Error )
			{
				trace ( "navigateToURL error : " + er.message );
			}
		}
		
		// PRIVATE
		
		private function destroy( link:MovieClip ):void
		{
			removeChild( link );
		}
		
		// PUBLIC
		
		public function init():void
		{
			while ( numChildren ) removeChildAt( 0 );
			
			var link:Link;
			var title:Title;
			
			var tf:TextFormat;
			var t:TextField;
			
			var colors:Array = Const.COLORS_LINKS;
			var names:Array = [ "Directors", "Production", "Post Production", "Story Boarder", "Sound" ];
			
			var s:String;
			var j:int;
			var m:int;
			var px:int;
			var py:int;
			var vy:int;
			var n:int = links.length;
			for ( var i:int; i < n; i++ )
			{
				title = new Title();
				title.txt.text = names[ i ];
				tf = title.txt.getTextFormat();
				tf.color = colors[ i ];
				title.txt.setTextFormat( tf );
				//link.z.enabled = false;
				
				if ( i == 3 )
				{
					px = 290;
					py = 0;
					
					vy = 0;
				}
				
				py += vy ? 40 : 0;
				title.x = px;
				title.y = py;
				
				py += 20;
				vy++;
				
				addChild( title );
				
				m = links[ i ].length;				
				for ( j = 0; j < m; j++ )
				{
					link = new Link();
					link.url = links[ i ][ j ].url;
					
					s = links[ i ][ j ].url;
					link.txt.text = s;
					link.mail = links[ i ][ j ].mail == "" ? false : true;
						
					//if ( links[ i ][ j ].mail == "" )
					//{						
						//link.mail = true;
					//}
					//else 
					//{
						//s = links[ i ][ j ].url
						//link.txt.text = s.replace( /[@]/, " [at] " );
						//link.mail = false;
					//}
					
					tf = link.txt.getTextFormat();
					tf.color = 0x000000;//colors[ int( Math.random() * colors.length ) ];
					link.txt.setTextFormat( tf );
					
					py += 25;
					link.x = px;
					link.y = py + 10;
					link.alpha = .2;
					
					TweenLite.to( link, .2, { y: link.y - 20, alpha: 1, delay: i * .01, ease: Back.easeOut } );
					
					link.z.addEventListener( MouseEvent.CLICK, onClick );
					
					addChild( link );
				}
			}
		}
		
		public function clear():void
		{
			var a:Array = [];
			
			var i:int;
			var n:int = numChildren;
			for ( i; i < n; i++ ) a.push( getChildAt( i ) );
			for ( i = 0; i < n; i++ ) TweenLite.to( a[ i ], .2, { y: a[ i ].y + 20, alpha: .2, delay: i * .01, ease: Back.easeOut, onComplete: destroy, onCompleteParams: [ a[ i ] ] } );
		}
		
	}
	
}