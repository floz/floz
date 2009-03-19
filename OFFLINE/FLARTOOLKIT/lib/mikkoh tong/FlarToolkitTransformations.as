package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.ByteArray;
	
	import org.libspark.flartoolkit.core.FLARCode;
	import org.libspark.flartoolkit.core.param.FLARParam;
	import org.libspark.flartoolkit.core.raster.rgb.FLARRgbRaster_BitmapData;
	import org.libspark.flartoolkit.core.transmat.FLARTransMatResult;
	import org.libspark.flartoolkit.detector.FLARSingleMarkerDetector;
	import org.libspark.flartoolkit.pv3d.FLARCamera3D;
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.Collada;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.render.LazyRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.view.stats.StatsView;
	
	/**
	 * ...
	 * @author Mikko Haapoja
	 */
	[SWF(width="980", height="570", framerate="30", backgroundColor="#FFFFFF")]
	public class FlarToolkitTransformations extends Sprite 
	{
		[Embed(source="../lib/camera_para.dat", mimeType="application/octet-stream")]
		private var CameraParameters:Class;
		
		[Embed(source="../lib/p_marker.pat", mimeType="application/octet-stream")]
		private var MarkerPattern:Class;
		
		private const EASE:Number=0.3;
		
		private var cameraParameters:FLARParam;
		private var markerPattern:FLARCode;
		private var raster:FLARRgbRaster_BitmapData;
		private var detector:FLARSingleMarkerDetector;
		private var trans:FLARTransMatResult;
		
		private var cam:Camera;
		private var vid:Video;
		private var capture:BitmapData;
		
		private var cam3D:FLARCamera3D;
		private var scene:Scene3D;
		private var viewPort:Viewport3D;
		private var renderer:LazyRenderEngine;
		
		private var mouthContainer:DisplayObject3D;
		private var mouth:Collada;
		private var blockerCube:Cube;
		
		private var obRotation:Number3D;
		private var obPosition:Number3D;
		
		private var stats:StatsView;
		
		private var currentTongueBmd:BitmapData;
		private var originalTongueBmd:BitmapData;
		
		private var currentMouthBmd:BitmapData;
		private var originalMouthBmd:BitmapData;
		
		private var tongueMat:BitmapFileMaterial;
		private var mouthMat:BitmapFileMaterial;
		
		private var tongue:DisplayObject3D;
		private var prevMouthX:Number=0;
		private var prevMouthZ:Number=0;
		
		public function FlarToolkitTransformations():void 
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			
			cameraParameters = new FLARParam();
			cameraParameters.loadARParam(new CameraParameters() as ByteArray);
			cameraParameters.changeScreenSize(320, 240);

			markerPattern = new FLARCode(16, 16);
			markerPattern.loadARPatt(new MarkerPattern());
			
			cam = Camera.getCamera();
			cam.setMode(320, 240, 30);
			
			vid = new Video(320, 240);
			vid.attachCamera(cam);
			addChild(vid);
			
			capture = new BitmapData(vid.width, vid.height, false, 0x0);
			//capture.draw(vid);
			
			raster = new FLARRgbRaster_BitmapData(capture);
			detector = new FLARSingleMarkerDetector(cameraParameters, markerPattern, 80);
			
			cam3D = new FLARCamera3D(cameraParameters);
			
			scene = new Scene3D();
			
			viewPort = new Viewport3D(vid.width, vid.height);
			addChild(viewPort);
			
			renderer = new LazyRenderEngine(scene, cam3D, viewPort);
			
			stats=new StatsView(renderer);
			addChild(stats);
			
			create3dObjects();
		
			trans = new FLARTransMatResult();
			
			vid.scaleX=-2;
			vid.scaleY=2;
			viewPort.scaleX=-2;
			viewPort.scaleY=2;
			
			vid.x=stage.stageWidth/2-vid.width/2+vid.width;
			vid.y=stage.stageHeight/2-vid.height/2;
			viewPort.x=vid.x;
			viewPort.y=vid.y;
			
			viewPort.filters=[
                            	new ColorMatrixFilter([
	                                1, 0, 0, 0, 0,
	                                0, 1, 0, 0, 0,
	                                0, 0, 1, 0, 0,
	                                1, 1, -1, 1, 0
                            	])
                       		 ];
		}	
		
		private function create3dObjects():void
		{
			mouthContainer=new DisplayObject3D();
			
			mouth=new Collada("http://www.mikkoh.com/blog/wp-content/uploads/2009/02/3dStuff/mouth.dae");
			mouth.addEventListener(FileLoadEvent.COLLADA_MATERIALS_DONE, colladaLoaded);
			mouth.rotationX+=90;
			mouth.rotationZ+=180;
			mouth.scale=0.17;
			mouth.y+=30;
			mouth.z-=20;
			
			var blueMat:ColorMaterial=new ColorMaterial(0x0000FF);
			var blockerMats:MaterialsList=new MaterialsList({
																top: blueMat,
																bottom: blueMat,
																left: blueMat,
																right: blueMat,
																front: null,
																back: blueMat
															});
			blockerCube=new Cube(blockerMats, 95, 95, 95, 3, 3, 3);
			blockerCube.y=mouth.y-30;
			blockerCube.z=mouth.z-30;
			mouthContainer.addChild(blockerCube);
			
			scene.addChild(mouthContainer);
		}
		
		private function colladaLoaded(ev:FileLoadEvent):void
		{
			mouthContainer.addChild(mouth);
			
			mouthMat=mouth.getMaterialByName("mouth_jpg") as BitmapFileMaterial;
			tongueMat=mouth.getMaterialByName("tongue_jpg") as BitmapFileMaterial;
			
			originalMouthBmd=mouthMat.bitmap.clone();
			originalTongueBmd=tongueMat.bitmap.clone();
			
			currentMouthBmd=mouthMat.bitmap;
			currentTongueBmd=tongueMat.bitmap;
			
			var tempTongue:DisplayObject3D=mouth.getChildByName("Tongue");
			tongue=new DisplayObject3D();
			
			tongue.addChild(tempTongue);
			
			tongue.x=tempTongue.x;
			tongue.y=tempTongue.y-230;
			tongue.z=tempTongue.z-100;
			
			tempTongue.x=0;
			tempTongue.y=230;
			tempTongue.z=100;
			
			mouth.removeChild(tempTongue);
			mouth.addChild(tongue);
			
			this.addEventListener(Event.ENTER_FRAME, mainEnter);
		}
		
		private function mainEnter(e:Event):void 
		{
			capture.draw(vid);
			
			if (detector.detectMarkerLite(raster, 70) && detector.getConfidence() > 0.5)
			{
				detector.getTransformMatrix(trans);
				
				var mat:Matrix3D = new Matrix3D();
				mat.n11 =  trans.m01; mat.n12 =  trans.m00; mat.n13 =  trans.m02; mat.n14 =  trans.m03;
				mat.n21 = -trans.m11; mat.n22 = -trans.m10; mat.n23 = -trans.m12; mat.n24 = -trans.m13;
				mat.n31 =  trans.m21; mat.n32 =  trans.m20; mat.n33 =  trans.m22; mat.n34 =  trans.m23;
				
				obPosition=new Number3D(mat.n14, mat.n24, mat.n34);
				obRotation=Matrix3D.matrix2euler(mat);
			}
			
			if(obRotation)
			{
				mouthContainer.x+=(obPosition.x-mouthContainer.x)*EASE;
				mouthContainer.y+=(obPosition.y-mouthContainer.y)*EASE;
				mouthContainer.z+=(obPosition.z-mouthContainer.z)*EASE;
				
				var dAX:Number=getShortestAngle(obRotation.x, mouthContainer.rotationX);
				var dAY:Number=getShortestAngle(obRotation.y, mouthContainer.rotationY);
				var dAZ:Number=getShortestAngle(obRotation.z, mouthContainer.rotationZ);

				mouthContainer.rotationX+=dAX*EASE;
				mouthContainer.rotationY+=dAY*EASE;
				mouthContainer.rotationZ+=dAZ*EASE;
				
				setMouthColour();
				rotateTongue();
			}
		}
		
		private function setMouthColour():void
		{
			var redAmount:Number=1;
			var greenAmount:Number=1;
			var blueAmount:Number=1;
			
			var sickDistance:Number=Math.abs(getShortestAngle(mouthContainer.rotationZ, 0));
	
			if(sickDistance<=90)
			{
				redAmount=sickDistance/90;
				greenAmount=1+(1-(sickDistance/90))*2;
				blueAmount=sickDistance/90;
			}
			
			var curGreenTrans:ColorTransform=new ColorTransform(redAmount, greenAmount, blueAmount, 1);
					
			currentTongueBmd.draw(originalTongueBmd, null, curGreenTrans);
			currentMouthBmd.draw(originalMouthBmd, null, curGreenTrans);
			
			renderer.render();
		}
		
		private function rotateTongue():void
		{
			var rX:Number=0;
			var rY:Number=0;
			var rZ:Number=0;
			
			var dX:Number=prevMouthX-mouthContainer.x;
			var dZ:Number=prevMouthZ-mouthContainer.z;
			
			if(dX<-10)
			{
				rY=30;
				rZ=30;
			}
			else if(dX>10)
			{
				rY=-30;
				rZ=-30;
			}
		
			if(dZ<-10)
			{
				rX=-30;
			}
			else if(dZ>10)
			{
				rX=80;
			}
			
			tongue.rotationX+=(rX-tongue.rotationX)*0.3;
			tongue.rotationY+=(rY-tongue.rotationY)*0.3;
			tongue.rotationZ+=(rZ-tongue.rotationZ)*0.3;

			prevMouthX=mouthContainer.x;
			prevMouthZ=mouthContainer.z;
		}
		
		private function getShortestAngle(angle1:Number, angle2:Number):Number
		{
		    var angle:Number=(angle1-angle2)%360;
		    
		    if(angle>180)
		    {
		    	angle=angle-360;
		    }
		    else if(angle<-180)
		    {
		    	angle=angle+360;
		    }
		    
		    return angle;
		}
	}
	
}