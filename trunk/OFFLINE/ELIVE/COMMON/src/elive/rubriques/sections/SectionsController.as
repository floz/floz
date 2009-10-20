/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.rubriques.sections 
{
	import assets.GPanelMask;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.motion.M4Tween;
	
	public class SectionsController extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const _posX:int = 300;
		
		private var _sections:Vector.<Section>;
		private var _mask:Sprite;
		private var _cnt:Sprite;
		
		private var _currentSection:Section;
		private var _currentSectionId:int = -1;
		
		private var _newSection:Section;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SectionsController() 
		{
			init();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			_currentSection = null;
			_newSection = null;
			_sections = null;
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_sections = new Vector.<Section>( 0, false );
			
			_mask = new GPanelMask();
			_mask.x = -5;
			addChild( _mask );
			
			_cnt = new Sprite();
			addChild( _cnt );
			
			_cnt.cacheAsBitmap = 
			_mask.cacheAsBitmap = true;
			_cnt.mask = _mask;
		}
		
		private function slideTo( sectionId:int, id:int = -1 ):void
		{
			_newSection = _sections[ sectionId ];
			
			if ( id >= 0 ) _newSection.linkTo( id );
			_currentSection.deactivate();
			
			if ( _currentSectionId < sectionId )
			{
				_newSection.x = _posX;
				_cnt.addChild( _newSection );
				
				M4Tween.to( _newSection, .25, { x: _newSection.x -_posX } );
				M4Tween.to( _currentSection, .25, { x: _currentSection.x -_posX } ).onComplete( configNewSection );
			}
			else
			{
				_newSection.x = -_posX;
				_cnt.addChild( _newSection );
				
				M4Tween.to( _newSection, .25, { x: _newSection.x + _posX } );
				M4Tween.to( _currentSection, .25, { x: _currentSection.x + _posX } ).onComplete( configNewSection );
			}
		}
		
		private function configNewSection():void
		{
			M4Tween.killTweensOf( _newSection );
			M4Tween.killTweensOf( _currentSection );
			
			_cnt.removeChild( _currentSection );
			_currentSection = _newSection;
			_newSection = null;
			
			_currentSection.activate();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addSection( section:Section, sectionId:int ):void
		{
			_sections[ sectionId ] = section;			
		}
		
		public function navigateTo( sectionId:int, id:int = -1 ):void
		{
			if ( ( sectionId < 0 ) || ( sectionId > _sections.length ) )
				throw new Error( "L'id '" + sectionId + "' ne fait référence à aucune section." );
			
			if ( _currentSection )
			{
				slideTo( sectionId, id );
			}
			else 
			{
				_currentSection = _sections[ sectionId ];
				if ( id >= 0 ) _currentSection.linkTo( id );
				_cnt.addChild( _currentSection );
			}
			_currentSectionId = sectionId;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}