package com.isoo.algo 
{
	import com.isoo.objects.IsoObject;
	/**
	 * ...
	 * @author David Ronai
	 */
	public class Sort
	{
		
		public function Sort() 
		{
			
		}
		
		public static function quicksort( array:Vector.<IsoObject> ):void 
		{
			startQuickSort( array, 0, array.length - 1);
		}
		
		private static function partition( tableau:Vector.<IsoObject>, deb:int, fin:int):int
		{
			var compt:int = deb;
			var pivot:int = tableau[deb].depth;
			
			for(var i:int=deb+1;i<=fin;i++)
			{
				if (tableau[i].depth < pivot)
				{
					compt++;
					echanger(tableau,compt,i);
				}
			}
			echanger(tableau,deb,compt);
			return compt;
		}
		
		private static function startQuickSort(t:Vector.<IsoObject>, start:int, end:int):void
        {
			if ( start <  end) 
			{
				if ( t.length <= 15 ){
					triDeShell(t, t.length);
				}
				else{
					var indicePivot:int = partition(t, start, end);
					startQuickSort(t, start, indicePivot - 1);
					startQuickSort(t, indicePivot + 1, end);
				}
			}
        }

		static private function echanger(tableau:Vector.<IsoObject>, index1:int, index2:int):void
		{
			var o:IsoObject = tableau[index1];
			tableau[index1] = tableau[index2];
			tableau[index2] = o;
		}
		
		public static function insertion( tab:Vector.<IsoObject>, tailleLogique:int):void
		{
			var cpt:int;
			var element:IsoObject;
		 
			for(var i:int = 1; i < tailleLogique ; i++)
			{    
				element = tab[i];
				cpt = i-1;
				while (cpt >= 0 && tab[cpt].depth > element.depth) {
				   tab[cpt+1] = tab[cpt];
				   cpt--;
				}
				tab[cpt+1] = element;
			}
		}
		
		public static function triDeShell(tab:Vector.<IsoObject>, tailleLogique:int):void
		{
		   var pas:int = 1;
		   while ( pas < tailleLogique / 9)
		   {
			  pas = pas*3 + 1;
		   }
		   while (pas > 0)
		   {   
				for (var serie:int = 0; serie <= pas - 1; serie ++) 
				{
					var position:int = serie + pas;
					
					var elm:IsoObject;
					var positionComparer:int;
					
					while(position < tailleLogique) {
						elm = tab[position];
						positionComparer = position - pas;
			 
						while ((positionComparer >= 0) && (elm.depth < tab[positionComparer].depth)) 
						{
						   tab[positionComparer + pas] = tab[positionComparer];
						   positionComparer -= pas;
						}
						tab [positionComparer + pas] = elm;
						position += pas;
					}
				}         		
				pas = pas/3;	
		   }      
		}

	}

}