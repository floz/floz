package main 
{
	
	public class Particule 
	{
		public  var _sx:Number;
		public  var _sy:Number;
		
		public var _vx:Number;
		public var _vy:Number;
		
		public var _energie:Number;
		public var _energieDamp:Number;
		
		public function Particule( sx:Number, sy:Number, vx:Number, vy:Number, energie:Number, energieDamp:Number ); ) 
		{
			_sx = sx;
			_sy = sy;
			
			_vx = vx;
			_vy = vy;
			
			_energie = energie;
			_energieDamp = energieDamp;
		}
		
	}
	
}