
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package emagicien.onomatopeias 
{
	import assets.Ono1_FC;
	import assets.Ono10_FC;
	import assets.Ono11_FC;
	import assets.Ono12_FC;
	import assets.Ono2_FC;
	import assets.Ono3_FC;
	import assets.Ono4_FC;
	import assets.Ono5_FC;
	import assets.Ono6_FC;
	import assets.Ono7_FC;
	import assets.Ono8_FC;
	import assets.Ono9_FC;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	
	public class Onomatopeias extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _classes:Vector.<Class>;
		private var _classesAvailable:Vector.<Class>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Onomatopeias() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_classes = new Vector.<Class>( 12, true );
			_classes[ 0 ] = Ono1_FC;
			_classes[ 1 ] = Ono2_FC;
			_classes[ 2 ] = Ono3_FC;
			_classes[ 3 ] = Ono4_FC;
			_classes[ 4 ] = Ono5_FC;
			_classes[ 5 ] = Ono6_FC;
			_classes[ 6 ] = Ono7_FC;
			_classes[ 7 ] = Ono8_FC;
			_classes[ 8 ] = Ono9_FC;
			_classes[ 9 ] = Ono10_FC;
			_classes[ 10 ] = Ono11_FC;
			_classes[ 11 ] = Ono12_FC;
			
			_classesAvailable = new Vector.<Class>( 12, false );
			fillAvailablesVector();
		}
		
		private function fillAvailablesVector():void
		{
			var n:int = _classes.length;
			for ( var i:int; i < n; ++i )
				_classesAvailable[ i ] = _classes[ i ];
		}
		
		private function getOnomatop():MovieClip
		{
			var l:int = _classesAvailable.length;
			if ( l == 0 ) 
			{
				fillAvailablesVector();
				return getOnomatop();
			}
			
			var idx:int = int( Math.random() * l ) - 1;
			var c:Class = _classesAvailable.splice( idx, 1 )[ 0 ];
			return MovieClip( new c );
		}
		
		private function destroyItem( item:MovieClip ):void
		{
			TweenMax.to( item, .5, { frame: 1, alpha: 0, onComplete: removeItem, onCompleteParams: [ item ] } );
		}
		
		private function removeItem( item:MovieClip ):void
		{
			removeChild( item );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addOnomatopAt( point:Point ):void
		{
			var ono:MovieClip = getOnomatop();
			ono.x = point.x;
			ono.y = point.y;
			addChild( ono );
			TweenMax.to( ono, .8, { frame: ono.totalFrames } );
			TweenMax.to( ono, .8, { delay: .15, onComplete: destroyItem, onCompleteParams: [ ono ] } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}