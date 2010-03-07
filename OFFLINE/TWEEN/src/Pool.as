﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.geom.Point;
	import fr.minuit4.motion.M4Tween;
	
	public class Pool extends Point
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const GROWTH_RATE:int = 1;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _availableInPool:int;
		private static var _allowInstanciation:Boolean;
		private static var _currentPoint:Pool;
		
		private var previous:Pool;
		private var next:Pool;
		
		private var _name:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Pool() 
		{
			if ( !_allowInstanciation ) throw new Error( "erreur" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function create( x:Number, y:Number, name:String ):Pool
		{
			var poolPoint:Pool;
			if ( !_availableInPool )
			{
				var i:int = GROWTH_RATE;
				while ( --i > -1 )
				{
					_allowInstanciation = true; {
						poolPoint = new Pool();
					} _allowInstanciation = false;
					
					poolPoint.next = _currentPoint;
					_currentPoint = poolPoint;
				}
				_availableInPool += GROWTH_RATE;
			}
			
			poolPoint = _currentPoint;
			_currentPoint = poolPoint.next;
			--_availableInPool;
			
			poolPoint.x = x;
			poolPoint.y = y;
			poolPoint._name = name;
			
			return poolPoint;
		}
		
		public static function release( poolPoint:Pool ):void
		{
			trace( _currentPoint );
			poolPoint.next = _currentPoint;
			_currentPoint = poolPoint;
			
			++_availableInPool;
		}
		
		public function dispose():void
		{
			release( this );
		}
		
		public function getName():String
		{
			return _name;
		}
		
		//public override function toString():String { return this._name; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}