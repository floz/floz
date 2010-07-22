package com.isoo.map 
{
	/**
	 * ...
	 * @author David Ronai
	 */
	public class Flag
	{
		
		public static const NONE:int 		= 0x000000;
		
		public static const WALKABLE:int	= 0x000001;
		public static const KILLABLE:int	= 0x000002;
		
		public static const START:int		= 0x000004;
		public static const END:int			= 0x000008;
		
		public static const VISIBLE:int 	= 0x000010;
		
		public function Flag() 
		{
			throw new Error("You can't create an instance of Flag");
		}
		
	}

}