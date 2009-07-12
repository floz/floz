
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.motion.v3
{
	import flash.utils.getTimer;
	import fr.minuit4.motion.easing.Linear;
	
	public class M4Tween 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _target:Object;
		//private var _tweensInfos:/*M4TweenInfos*/Array = [];
		private var _tweensInfos:M4TweenInfos;
		private var _reservedParams:Object = { name: 0, delay: 0, easing: 0, onInit: 0, onUpdate: 0, onComplete: 0, onInitParams: 0, onUpdateParams: 0, onCompleteParams: 0 };
		
		private var _enabled:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function M4Tween() 
		{
			//
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function initialize( target:Object, duration:Number, params:Object ):void
		{
			_target = target;
			
			var rp:Array = [];
			var fp:Array = [];
			var property:String;
			for ( property in params )
			{
				if ( property in _reservedParams )
					rp.push( { property: property, value: params[ property ] } );
				else
					fp.push( { property: property, value: params[ property ] } );
			}
			
			_tweensInfos = new M4TweenInfos();
			var ti:M4TweenInfos = _tweensInfos;
			
			var value:Number;
			var j:int;
			var m:int = rp.length;
			var i:int = fp.length;
			while ( --i > -1 )
			{
				property = fp[ i ].property;
				value = fp[ i ].value;
				
				ti.property = property;
				ti.startValue = target[ property ];
				ti.endValue = value;
				ti.duration = duration;
				
				j = m;
				while ( --j > -1 )
					ti[ rp[ j ].property ] = rp[ j ].value;
				
				if ( !ti.delay ) ti.delay = 0;
				if ( typeof( ti.easing ) != "function" ) ti.easing = Linear.easeIn;
				ti.startTime = getTimer() + ti.delay * 1000;
				ti.endTime = ti.startTime + ti.duration * 1000;
				
				if( i > 0 ) ti = ti.next = new M4TweenInfos();
			}
			
			this._enabled = true;
		}
		
		public function update( time:int ):int
		{
			var t:Number; // Specifies the current time, between 0 and duration inclusive. 
			var b:Number; // Specifies the initial value of the animation property. 
			var c:Number; // Specifies the total change in the animation property. 
			var d:Number; // Specifies the duration of the motion.
			
			var value:Number;
			
			var ti:M4TweenInfos = _tweensInfos;
			var count:int;
			while ( ti )
			{
				if ( !ti.complete )
				{
					if ( time >= ti.startTime )
					{
						t = time - ti.startTime;
						b = ti.startValue;
						c = ti.endValue - ti.startValue;
						d = ti.duration * 1000;
						value = ti.easing( t, b, c, d );
						
						_target[ ti.property ] = value;
						
						if ( time >= ti.endTime ) 
						{
							_target[ ti.property ] = ti.endValue; // bizarre !
							ti.complete = true;
						}
					}
					++count;
				}
				ti = ti.next;
			}
			
			return count;
		}
		
		public function dispose():void
		{	
			_target = null;
			
			this._enabled = false;
		}
		
		public function isEnabled():Boolean
		{
			return this._enabled;
		}
		
		public function getTarget():Object { return this._target; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}