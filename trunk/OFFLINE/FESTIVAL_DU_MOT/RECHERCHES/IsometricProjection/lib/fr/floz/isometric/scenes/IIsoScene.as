package fr.floz.isometric.scenes 
{
	import fr.floz.isometric.core.IRenderable;
	import fr.floz.isometric.core.IsoDisplayObject;
	
	public interface IIsoScene extends IRenderable
	{
		function addBackgroundItem( item:IsoDisplayObject ):Boolean;
		function addMobile( item:IsoDisplayObject ):Boolean;
		function addForegroundItem( item:IsoDisplayObject ):Boolean;
	}
	
}