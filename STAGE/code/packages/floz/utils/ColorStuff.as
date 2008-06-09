package code.packages.utils 
{
	public class ColorStuff 
	{
		
		static public function mixColors( colorStart:uint, colorEnd:uint, ratio:Number ):Number 
		{
			var c1:Object = { r: colorStart >> 16 & 0xFF, v: colorStart >> 8 & 0xFF, b: colorStart & 0xFF };
			var c2:Object = { r: colorEnd >> 16 & 0xFF, v: colorEnd >> 8 & 0xFF, b: colorEnd & 0xFF };
			
			var nbr:Number = c1.r + (c2.r - c1.r) * ratio ) << 16 | c1.v + (c2.v - c1.v) * ratio ) << 8 | c1.b + (c2.b - c1.b) * ratio;
			
			return nbr;
		}
		
	}
	
}