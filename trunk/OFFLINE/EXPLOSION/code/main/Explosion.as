package main 
{
	
	public class Explosion 
	{
		private var _t_particules:Array;
		private var _c_particules:Array;
		private var _energie:Number;
		
		public function Explosion( x:Number, y:Number ) 
		{
			init( x, y );
		}
		
		private function init( x:Number, y:Number ):void
		{
			_t_particules = [];
			_c_particules = [];
			
			_energie = 1;
			
			var a:Number;
			var s:Number;
			var l:Number;
			
			var particle:Particule
		}
		
	}
	
}