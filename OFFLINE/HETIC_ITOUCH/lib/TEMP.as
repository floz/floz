
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package lib 
{
	import flash.display.MovieClip;
	
	public class TEMP extends MovieClip 
	{
		
		public function TEMP() 
		{
						//Move the plane "back" 600 so you can create a bezier to that point
			//This helps the camera from just going through the plane
			target.moveBackward( 2000 );

			var bezier:Array = new Array();
			bezier.push
			({
			x: target.x,
			y: target.y,
			z: target.z

			});

			//Move the camera forward 550 (still 50 back from the original position
			//We'll use this as the point where the camera will end up
			target.moveForward( 2000 - 50 );

			Tweener.addTween( _view.camera, {
					x: target.x,
					y: target.y,
					z: target.z,
					//_bezier: bezier,

					time: .5
					});

			//I just like the effect of the rotation finishing after the position Tween has finished
			//so i set the time here to 8 (3 seconds longer than the position Tween
			Tweener.addTween(
			_view.camera,
			{
			rotationX: target.rotationX,
			rotationY: target.rotationY,
			rotationZ: target.rotationZ,

			time: 1
			}
			);

			//Move the plane back to it's original position
			//This makes it look like the plane never moved
			target.moveForward( 50 );
		}
		
		// EVENTS
		
		// PRIVATE	
		
		// PUBLIC
		
	}
	
}