
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import com.carlcalderon.arthropod.Debug;
	import commun.Loading;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import fr.minuit4.utils.UBit;
	
	public class GuestInfos extends MovieClip
	{
		public var texte:TextField;
		public var cnt:MovieClip;
		
		private var type:String;
		
		private var loading:Loading;
		
		private var guest:MovieClip;
		private var _loaded:Boolean;
		
		public function GuestInfos() 
		{
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
			
			loading = new Loading( 0xffffff, 5, 6, 12 );
			loading.x = ( 261 >> 1 ) - loading.width;
			loading.y = ( 297 >> 1 ) - loading.height;
			cnt.addChild( loading );
			
			loading.play();
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function display( m:MovieClip ):void
		{			
			this.guest = m;
			
			var bmd:BitmapData = new BitmapData( m.width, m.height, true, 0x000000 );
			bmd.draw( m );
			
			bmd = UBit.resize( bmd, 261, 297, true );
			var b:Bitmap = new Bitmap( bmd );
			
			loading.stop();
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			
			cnt.addChild( b );
			
			loading = null;
			_loaded = true;
		}
		
		// GETTERS & SETTERS
		
		public function getGuest():MovieClip
		{
			return this.guest;
		}
		
		public function setText( s:String ):void
		{
			texte.text = s;
		}
		
		public function setType( type:String ):void
		{
			this.type = type;
		}
		
		public function getType():String { return this.type; }
		
		public function get loaded():Boolean { return _loaded; }
		
	}
	
}