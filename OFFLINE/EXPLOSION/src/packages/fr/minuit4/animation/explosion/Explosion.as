
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.animation.explosion
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class Explosion 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		static private var _instances:Dictionary = new Dictionary();
		static private var _allowInstance:Boolean;
		static private var _numExplosions:int;
		
		private var _target:DisplayObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Explosion( target:DisplayObject ) 
		{
			if ( !Explosion._allowInstance ) throw new Error( "Cette classe ne peut pas être instanciée. Veuillez appeller la méthode static apply()" );
			Explosion._allowInstance = false;
			
			if ( !target.parent ) 
			{
				destroy();
				return;
			}
			
			this._target = target;
			
			Explosion._instances[ this ] = true;
			Explosion._numExplosions++;
			
			create();
			explode();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function destroy():void
		{
			if ( Explosion._instances[ this ] )
			{
				delete Explosion._instances[ this ];
				Explosion._numExplosions--;
			}
		}
		
		private function create():void
		{
			var bd:BitmapData = new BitmapData( _target.width, _target.height, true, 0x00 )
			bd.draw( _target );
			var b:Bitmap = new Bitmap( bd, PixelSnapping.AUTO, true );
			var s:Sprite = new Sprite();
			s.x = _target.x;
			s.y = _target.y;
			s.addChild( b );
			
			var targetParent:DisplayObjectContainer = _target.parent;
			var idx:int = targetParent.getChildIndex( _target );
			
			//targetParent.removeChild( _target );
			//targetParent.addChildAt( s, idx );
		}
		
		private function explode():void
		{
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		static public function apply( target:DisplayObject ):Explosion
		{
			Explosion._allowInstance = true;
			return new Explosion( target );
		}
		
		static public function get numExplosions():int
		{
			return Explosion._numExplosions;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}