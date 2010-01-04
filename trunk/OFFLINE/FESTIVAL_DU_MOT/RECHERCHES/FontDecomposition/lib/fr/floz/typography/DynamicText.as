
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.typography 
{
	import flash.display.Sprite;
	import net.badimon.five3D.typography.Typography3D;
	
	public class DynamicText extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _glyphes:Vector.<Glyph>;
		
		private var _text:String;
		private var _typography:Typography3D;
		private var _size:Number = 10;
		private var _letterSpacing:Number = 5;
		private var _color:uint;
		
		private var _sizeScaled:Number = _size * .01;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DynamicText( text:String = "", typography:Typography3D = null ) 
		{
			this._text = text;
			this._typography = typography;
			
			update();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function update():void
		{
			if ( !_typography ) return;
			if ( !_text || _text == "" ) return;
			
			while ( numChildren ) removeChildAt( 0 );
			
			var glyph:Glyph;
			var char:String;
			var n:int = _text.length;
			_glyphes = new Vector.<Glyph>( n, true );
			for ( var i:int; i < n; ++i )
			{
				char = _text.substr( i, 1 );
				glyph = new Glyph( char, _typography.getMotif( char ) );
				_glyphes[ i ] = glyph;
				
				addChild( glyph );
			}
			
			resize();
		}
		
		private function resize():void
		{
			var glyph:Glyph;
			var n:int = numChildren;
			for ( var i:int; i < n; ++i )
			{
				glyph = Glyph( getChildAt( i ) );
				glyph.scaleX =
				glyph.scaleY = _sizeScaled;
			}
			
			replace();
		}
		
		private function replace():void
		{
			var glyph:Glyph;
			var w:Number = 0;
			var n:int = numChildren;
			for ( var i:int; i < n; ++i )
			{
				glyph = Glyph( getChildAt( i ) );
				glyph.x = w;
				
				w += ( _typography.getWidth( glyph.glyphName ) + _letterSpacing ) * _sizeScaled;
			}
		}		
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function set text( value:String ):void
		{
			this._text = value;
			update();
		}
		public function get text():String { return _text; } 
		
		public function set typography( value:Typography3D ):void
		{
			this._typography = value;
			update();
		}
		public function get typography():Typography3D { return this._typography; }
		
		public function set size( value:Number ):void
		{
			this._size = value;
			_sizeScaled = _size * .01;			
			resize();
		}
		public function get size():Number { return this._size; }
		
		public function set letterSpacing( value:Number ):void
		{
			this._letterSpacing = value;
			replace();
		}
		public function get letterSpacing():Number { return this._letterSpacing; }
		
		public function set color( value:uint ):void
		{
			this._color = value;
		}
		public function get color():uint { return this._color; }
		
	}
	
}