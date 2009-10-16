/**
 * @author      : Arno - Arnaud NICOLAS
 * Version      : 1.0
 * Name         : UIUnfolding
 * Decription   : Class d'animation de multiples planes se déployant automatiquement
 */
package fr.minuit4.papervision3D.animation 
{
	import flash.events.Event;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.view.BasicView;
	import flash.filters.DropShadowFilter;
	import flash.events.ProgressEvent;
	import fr.minuit4.utils.UPosition;
	import gs.TweenLite;
	
	public class Unfolding extends DisplayObject3D
	{
		private var _time:int;
		private var _view:BasicView;
		private var _material:MaterialObject3D;
		private var _horizontalPlanes:int;
		private var _vertivalPlanes:int;
		private var _sizePlanes:int;
		
		private var _bufferX:int;
		private var _bufferY:int;
		
		
		/**
		 * Constructor
		 * @param	pView		BasicView		View Papervision à laquelle on ajoute l'UIUnfolding
		 * @param	pNbHPlanes		int		Nombre de planes horizontaux
		 * @param	pNbVPlanes		int		Nombre de planes verticaux
		 * @param	pSizePlanes		int		Largeur d'un plane (px)
		 * @param	pTime		int		Temps pour déplier la totalité des planes
		 * @param	pMaterial		MaterialObject3D		Materiel habillant les planes
		 */
		public function Unfolding(pView:BasicView = null, pNbHPlanes:int = 6, pNbVPlanes:int = 5, pSizePlanes:int = 200, pTime:int = 4, pMaterial:MaterialObject3D = null) 
		{
			if (!pView) return;
			_view = pView;
			_material = (pMaterial)?pMaterial:new ColorMaterial(0x000000, 1, false);
			_horizontalPlanes = pNbHPlanes;
			_vertivalPlanes = pNbVPlanes;
			_sizePlanes = pSizePlanes;
			_time = pTime;
			_bufferX = -(_horizontalPlanes * _sizePlanes) / 2;
			_bufferY = (_vertivalPlanes * _sizePlanes) / 2 - _sizePlanes;
			launchUnfolding();
		}
		
		
		/**
		 * Méthode privée initiant le dépliage
		 * Dispatch l'évènement Event.INIT
		 */
		private function launchUnfolding():void
		{
			this.dispatchEvent(new Event(Event.INIT));
			var mp:MovedPlane = new MovedPlane(_sizePlanes, _material);
			UPosition.define(mp, _bufferX, _bufferY);
			this.addChild(mp);
			unfold(_bufferX, _bufferY, _horizontalPlanes-1,_vertivalPlanes-1, true);
		}
		
		
		/**
		 * Méthode privée de récurcivité pour la création et le dépliage de tous les planes
		 * @param	pBufferX		int		Position en X du dernier plane déclenchant le dépliage
		 * @param	pBufferY		int		Position en Y du dernier plane déclenchant le dépliage
		 * @param	pHorizontals		int		Nombre de planes horizontaux restants
		 * @param	pVerticals		int		Nombre de planes verticaux restants
		 * @param	pHasNextBottom		Boolean		Indique si il faut déplier un nouveau plane vers le bas		
		 */
		private function unfold(pBufferX:int, pBufferY:int, pHorizontals:int, pVerticals:int, pHasNextBottom:Boolean):void
		{
			if (!pHorizontals && !pVerticals) endOfUnfolding();
			this.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
			if (pHorizontals)
			{
				var mR:UIMovedPlane = new UIMovedPlane(_sizePlanes, _material);
				trace(mR.name);
				UPosition.define(mR, pBufferX + _sizePlanes, pBufferY);
				mR.rotationY = -180;
				TweenLite.to(mR, _time/(_vertivalPlanes+_horizontalPlanes-1), { rotationY:mR.rotationY - 180, onUpdate:updateView, onComplete:function():void{unfold(pBufferX +_sizePlanes, pBufferY, pHorizontals-1, pVerticals, false);}});
				this.addChild(mR);
			}
			if (pHasNextBottom && pVerticals)
			{
				var mB:UIMovedPlane = new UIMovedPlane(_sizePlanes, _material);
				UPosition.define(mB, pBufferX, pBufferY);
				TweenLite.to(mB, _time/(_vertivalPlanes+_horizontalPlanes-1), { rotationX:mB.rotationX + 180, onUpdate:updateView, onComplete:function():void { unfold(_bufferX, pBufferY - _sizePlanes, _horizontalPlanes-1, pVerticals-1, true);}});
				this.addChild(mB);
			}
		}
		
		
		/**
		 * Méthode privée appelé dès lors que le dépliage est achevé
		 * Distpach l'évènement Event.COMPLETE
		 */
		private function endOfUnfolding():void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));
			_material = null;
			_view = null;
		}
		
		
		/**
		 * Méthode privée de render de la view avec l'application d'un filtre DropShadowFilter
		 */
		private function updateView():void
		{
			_view.singleRender();
			var o:DropShadowFilter = new DropShadowFilter(0, 0, 0x000000, 1, 6, 6);
			_view.filters = [o];
		}
		
	}
	
}