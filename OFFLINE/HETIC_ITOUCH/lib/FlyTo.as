package {
    import caurina.transitions.Tweener;
    import caurina.transitions.properties.CurveModifiers;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageQuality;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    
    import org.papervision3d.cameras.FreeCamera3D;
    import org.papervision3d.events.InteractiveScene3DEvent;
    import org.papervision3d.materials.BitmapFileMaterial;
    import org.papervision3d.objects.DisplayObject3D;
    import org.papervision3d.objects.primitives.Plane;
    import org.papervision3d.render.BasicRenderEngine;
    import org.papervision3d.scenes.Scene3D;
    import org.papervision3d.view.Viewport3D;
   
   [SWF(width="640", height="480", backgroundColor="0x000000", frameRate="30")]
    public class FlyTo extends Sprite
    {
        private var container:Sprite;
        private var scene:Scene3D;
        private var camera:FreeCamera3D;
   
        private var material:BitmapFileMaterial;
       
        private var planes:Array;
        
        private var currentPlane:DisplayObject3D;
        
        private var origin:DisplayObject3D;
       
        private static const NUM_PLANES:uint = 20;
        private static const BEZIER_DISTANCE:Number = 2000;
        private static const CAMERA_DISTANCE_FROM_PLANE:Number = 50;
       
        //needed with GreatWhite;
        private var viewport:Viewport3D;
        private var renderer:BasicRenderEngine;
       
        public function FlyTo()
        {
            init();
        }
       
        private function init():void
        {
            stage.quality = StageQuality.MEDIUM;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
           
           //allows for beziers with Tweener
           CurveModifiers.init();
           
            init3D();
            createMaterials();
            createObjects();
            createListeners();
        }
       
        private function init3D():void
        {
            //GW properties :
            viewport = new Viewport3D(stage.stageWidth , stage.stageHeight , true , true);
            renderer = new BasicRenderEngine();
            addChild(viewport);
            scene = new Scene3D();
           
            currentPlane = new DisplayObject3D();
            origin = new DisplayObject3D();
           
            camera = new FreeCamera3D();
            camera.zoom = 1;
            camera.focus = 350;
        }
       
        private function createMaterials():void
        {
            material = new BitmapFileMaterial( "http://pv3d.org/pics/me_and_son.jpg" );
            material.interactive = true;
            material.doubleSided = true;
            material.smooth = true;
        }
       
private function createObjects():void
{
    planes = new Array();
   
    for( var i:uint = 0; i < NUM_PLANES; i ++ )
    {
        var p:Plane = new Plane( material, 200, 200, 4, 4 );
        p.x = Math.random()* 4000 - 2000;
        p.y = Math.random()* 4000 - 2000;
        p.z = Math.random()* 4000 - 2000;
       
        p.rotationX = Math.random() * 180 -90;
        p.rotationY = Math.random() * 180 -90;
        p.rotationZ = Math.random() * 180 -90;
       
        scene.addChild( p );
        planes.push( p );
    }
}
       
        private function createListeners():void
        {
            for( var i:uint = 0; i < planes.length; i ++ )
            {
                planes[i].addEventListener( InteractiveScene3DEvent.OBJECT_CLICK, onObjectClick );
            }
            addEventListener( Event.ENTER_FRAME, onEnterFrame );
        }
       
        /*
         * On each click the plane will move back 500- the bezier will capture its position
         * Then move the plane forward 450- the camera end position will capture its position
         * Then move it back to its original location
         *
         * This is a bit of hack since you can just Tween to 500 in front of the plane
         * without moving the plane (or possibly creating a separate invisible plane
         * to where you want the camera to end up.
         */
private function onObjectClick( e:InteractiveScene3DEvent ):void
{
	var target:DisplayObject3D;
	
	//if you click the same plane twice in a row
	//send the camera back to 0,0,0
	if(currentPlane == e.displayObject3D)
	{
		//a new displayObject3D defaults to 0,0,0
		target = origin;	
	}else
	{
		target = e.displayObject3D;
	}
	
    //Move the plane "back" 600 so you can create a bezier to that point
    //This helps the camera from just going through the plane
   target.moveBackward( BEZIER_DISTANCE );
   
    var bezier:Array = new Array();
    bezier.push
    ({
        x:         target.x,
        y:         target.y,
        z:         target.z
       
    });
   
    //Move the camera forward 550 (still 50 back from the original position
    //We'll use this as the point where the camera will end up
    e.displayObject3D.moveForward( BEZIER_DISTANCE - CAMERA_DISTANCE_FROM_PLANE );
   
    Tweener.addTween(
        camera,
        {
            x:            target.x,
            y:            target.y,
            z:            target.z,
            _bezier:      bezier,
           
            time:        5
        }
    );
   
    //I just like the effect of the rotation finishing after the position Tween has finished
    //so i set the time here to 8 (3 seconds longer than the position Tween
    Tweener.addTween(
        camera,
        {
            rotationX:    target.rotationX,
            rotationY:    target.rotationY,
            rotationZ:    target.rotationZ,
           
            time:        8
        }
    );
   
    //Move the plane back to it's original position
    //This makes it look like the plane never moved
    target.moveForward( CAMERA_DISTANCE_FROM_PLANE );
    currentPlane = target;
}
       
        private function onEnterFrame( e:Event ):void
        {
            //GreatWhite rendering
            renderer.renderScene(scene , camera , viewport);
        }
    }
}
