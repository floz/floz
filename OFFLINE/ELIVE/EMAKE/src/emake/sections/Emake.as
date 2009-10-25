﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package emake.sections 
{
	import assets.GEmakeContent;
	import elive.rubriques.sections.Section;
	import elive.ui.EliveButton;
	import elive.utils.EliveUtils;
	import flash.display.Sprite;
	
	public class Emake extends Section
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _ongletTitle:GOngletSolo;
		private var _cntContent:Sprite;
		private var _cntButtons:Sprite;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const SECTION_ID:int = 0;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Emake() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_ongletTitle = new GOngletSolo();
			_ongletTitle.removeChild( _ongletTitle.tf );
			_ongletTitle.x = 3;
			addChild( _ongletTitle );
			
			_cntContent = new Sprite();
			_cntContent.x = 5;
			_cntContent.y = 50;
			addChild( _cntContent );
			_cntContent.addChild( new Formulaire() );
			
			buildButtons();
		}
		
		private function buildButtons():void
		{
			_cntButtons = new Sprite();
			_cntButtons.x = 5;
			_cntButtons.y = _cntContent.y + _cntContent.height + 10;
			addChild( _cntButtons );
			
			var btElivers:EliveButton = new EliveButton();
			btElivers.setText( "Recherche (e)livers" );
			_cntButtons.addChild( btElivers );
			
			var btElive:EliveButton = new EliveButton();
			btElive.setText( "(e)live !" );
			btElive.x = _cntContent.width - btElive.width;
			_cntButtons.addChild( btElive );
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}