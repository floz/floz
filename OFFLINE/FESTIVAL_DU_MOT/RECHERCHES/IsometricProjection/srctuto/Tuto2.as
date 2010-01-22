
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package 
{
	import as3isolib.core.ClassFactory;
	import as3isolib.core.IFactory;
	import as3isolib.display.IsoView;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.renderers.DefaultShadowRenderer;
	import as3isolib.display.renderers.SimpleSceneLayoutRenderer;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.graphics.SolidColorFill;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Tuto2 extends Sprite
	{
		private var box1:IsoBox;
		private var scene:IsoScene;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Tuto2() 
		{
			var box0:IsoBox = new IsoBox();
			box0.setSize( 25, 25, 25 );
			box0.moveTo( 0, 0, 0 );
			
			box1 = new IsoBox();
			box1.width = 10;
			box1.length = 25;
			box1.height = 50;
			box1.moveTo( 0, -120, 0 );
			box1.fills = [ new SolidColorFill( 0xff0000, .5 ),
						   new SolidColorFill(0x00ff00, .5),
						   new SolidColorFill(0x0000ff, .5),
						   new SolidColorFill(0xff0000, .5),
						   new SolidColorFill(0x00ff00, .5),
						   new SolidColorFill(0x0000ff, .5) ];
			
			var box2:IsoBox = new IsoBox();
			box2.setSize( 10, 50, 5 );	
			box2.moveTo( 200, 30, 10 );
			
			scene = new IsoScene();
			scene.addChild( box2 );
			scene.addChild( box1 );
			scene.addChild( box0 );
			
			//scene.layoutRenderer = new SimpleSceneLayoutRenderer();
			//scene.layoutEnabled = false;
			
			var grid:IsoGrid = new IsoGrid();
			grid.setGridSize( 50, 50 );
			grid.moveTo( 0, 0, 0 );
			grid.width = 500;
			scene.addChild( grid );
			
			var factory:ClassFactory = new ClassFactory(DefaultShadowRenderer);
			factory.properties = {shadowColor:0x000000, shadowAlpha:0.15, drawAll:false};
			scene.styleRenderers = [factory];

			
			var view:IsoView = new IsoView();
			view.x = 200;
			view.y = 100;
			view.setSize( 400, 300 );
			view.addScene( scene );
			
			addChild( view );
			
			scene.render();
			
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function enterFrameHandler(e:Event):void 
		{
			++box1.x;
			scene.render();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}