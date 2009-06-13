package painting.interfaces 
{
	
	public interface IBrushDatas 
	{
		function dispose():void;
		
		function get alphas():Vector.<Number>;
		
		function set alphas( value:Vector.<Number> ):void;
		
		function get colors():Vector.<uint>;
		
		function set colors( value:Vector.<uint> ):void;
		
		function get colorsIdx():int;
		
		function set colorsIdx( value:int ):void;
		
		function get alphasIdx():int;
		
		function set alphasIdx( value:int ):void;
	}
	
}