package maps.tiles 
{
	import flash.display.IBitmapDrawable;
	
	public interface ITile extends IBitmapDrawable
	{
		function get selected():Boolean;		
		function set selected( value:Boolean ):void;
		
		function get walkable():Boolean;
		function set walkable( value:Boolean ):void;
	}
	
}