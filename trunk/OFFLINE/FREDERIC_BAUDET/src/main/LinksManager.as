
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
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
			request = new URLRequest( e.currentTarget.parent.url );
			try
			{
				navigateToURL( request );
			}
			catch ( er:Error )
			{
				trace ( "navigateToURL error : " + er.message );
			}
		}
		
		// PRIVATE
		
		private function destroy( link:Link ):void
		{
			removeChild( link );
		}
		
		// PUBLIC
		
		public function init():void
		{
			while ( numChildren ) removeChildAt( 0 );
			
			var link:Link;
			
			var tf:TextFormat;
			var t:TextField;
			
			var colors:Array = Const.COLORS_VIVES;
			
			var n:int = links.length;
			for ( var i:int; i < n; i++ )
			{
				link = new Link();
				link.txt.text = links[ i ].nom + " " + links[ i ].prenom;
				
				tf = link.txt.getTextFormat();
				tf.color = colors[ int( Math.random() * colors.length ) ];
				link.txt.setTextFormat( tf );
				
				link.y = 40 * i;
				link.alpha = .2;
				link.url = links[ i ].url;
				
				TweenLite.to( link, .2, { y: link.y - 20, alpha: 1, delay: i * .05, ease: Back.easeOut } );
				
				link.z.addEventListener( MouseEvent.CLICK, onClick );
				
				addChild( link );
			}
		}
		
		public function clear():void
		{
			var a:Array = [];
			
			var i:int;
			var n:int = numChildren;
			for ( i; i < n; i++ ) a.push( getChildAt( i ) );
			for ( i = 0; i < n; i++ ) TweenLite.to( a[ i ], .2, { y: a[ i ].y + 20, alpha: .2, delay: i * .05, ease: Back.easeOut, onComplete: destroy, onCompleteParams: [ a[ i ] ] } );
		}
		
	}
	
}