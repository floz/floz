/**
 * @author      : Arno - Arnaud NICOLAS
 * Version      : 1.0
 * Name         : UIMovedPlane
 * Decription   : Class d'instanciation d'un plane décalé sur l'axe des abcisses ainsi que celui des ordonnées plaçant le plane en (0,0)
 */
package fr.minuit4.papervision3D.animation 
{
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import flash.filters.DropShadowFilter;
	import fr.minuit4.utils.UPosition;
	
	public class MovedPlane extends DisplayObject3D
	{
		private var _material:MaterialObject3D;
		private var _sideSize:int;
		private var _marginLeft:int;
		private var _marginTop:int;
		
		
		/**
		 * Constructor
		 * @param	pSideSize		int		Taille du plane (px)
		 * @param	pMaterial		MaterialObject		Materiel à appliquer sur le plane
		 * @param	pLeft		int		Marge à appliquer à gauche (référence : angle haut - gauche)
		 * @param	pTop		int		Marge à appliquer à droite (référence : angle haut - gauche)
		 */
		public function MovedPlane(pSideSize:int = 100, pMaterial:MaterialObject3D = null, pLeft:int = 0, pTop:int = 0) 
		{
			_material = (pMaterial)?pMaterial:new ColorMaterial(0x000000, 1, false);
			_material.doubleSided = true;
			_sideSize = pSideSize;
			_marginLeft = pLeft;
			_marginTop:pTop;
			initPlane();
		}
		
		
		/**
		 * Méthode privée de création du plane
		 */
		private function initPlane():void
		{
			var p:Plane = new Plane(_material, _sideSize, _sideSize, 1, 1);
			UPosition.define(p, _sideSize / 2 + _marginLeft, _sideSize / 2 + _marginTop);
			this.addChild(p);
		}
		
	}
	
}