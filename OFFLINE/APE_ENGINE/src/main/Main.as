
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.cove.ape.APEngine;
	import org.cove.ape.CircleParticle;
	import org.cove.ape.Group;
	import org.cove.ape.RectangleParticle;
	import org.cove.ape.Vector;
	import org.cove.ape.VectorForce;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			addEventListener(Event.ENTER_FRAME, run);
			 
			APEngine.init();
			APEngine.container = this;
			APEngine.addForce( new VectorForce( true, 0, 2 ) );
			 
			var defaultGroup:Group = new Group();
			defaultGroup.collideInternal = true;
			 
			var cp:CircleParticle = new CircleParticle(250,10,5);
			defaultGroup.addParticle(cp);
			 
			var rp:RectangleParticle = new RectangleParticle(250,300,300,50,0,true);
			defaultGroup.addParticle(rp);
			
			APEngine.addGroup(defaultGroup);
		}
		
		private function run(e:Event):void 
		{
			APEngine.step();
			APEngine.paint();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}