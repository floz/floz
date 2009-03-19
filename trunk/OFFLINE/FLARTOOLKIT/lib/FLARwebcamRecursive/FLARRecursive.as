package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.ByteArray;
	
	import org.libspark.flartoolkit.core.FLARCode;
	import org.libspark.flartoolkit.core.param.FLARParam;
	import org.libspark.flartoolkit.core.raster.rgb.FLARRgbRaster_BitmapData;
	import org.libspark.flartoolkit.core.transmat.FLARTransMatResult;
	import org.libspark.flartoolkit.detector.FLARSingleMarkerDetector;
	import org.libspark.flartoolkit.pv3d.FLARBaseNode;
	import org.libspark.flartoolkit.pv3d.FLARCamera3D;
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	
	[SWF(width="640", height="480", backgroundColor="#ffffff", frameRate="60")]
	public class FLARRecursive extends BasicView
	{
		[Embed(source="../assets/flar/camera_para.dat", mimeType="application/octet-stream")]
		private var CameraParameters:Class;

		[Embed(source="../assets/flar/p_marker.pat", mimeType="application/octet-stream")]
		private var MarkerPattern:Class;
		
		private static const WIDTH:Number = 640;
		private static const HEIGHT:Number = 480;
		private static const FRAMES_PER_SECOND:int = 60;
		
		private var cameraParameters:FLARParam;
		private var markerPattern:FLARCode;
		private var raster:FLARRgbRaster_BitmapData;
		private var detector:FLARSingleMarkerDetector;
		
		private var webCam:Camera;
		private var webcamDisplay:Video;
		private var capture:BitmapData;
		
		private var flarCamera3D:FLARCamera3D;
		private var flarBase:FLARBaseNode;
		
		private var transformationResult:FLARTransMatResult;
		
		private var plane:Plane;
		
		protected var threshold : int = 80; 
		protected var thresholdVariance : int = 1; 
		protected var counter : int = 0; 
		protected var thresholdBitmapData : BitmapData; 
		protected var thresholdBitmap : Bitmap; 
		
		public function FLARRecursive():void 
		{
			super(WIDTH * 2, HEIGHT * 2, false);
			init();
		}
		
		private function init():void
		{
			setupFlarCamera();
			setupFlarMarker();
			setupWebcam();
			setupWebcamDisplay();
			setupFlar();
			setupPapervision3D();
			
			startRendering(); 
		}
		
		private function setupFlarCamera():void
		{
			cameraParameters = new FLARParam();
			cameraParameters.loadARParam(new CameraParameters() as ByteArray);
		}
		
		private function setupFlarMarker():void
		{
			markerPattern = new FLARCode(16, 16);
			markerPattern.loadARPatt(new MarkerPattern());
		}
		
		private function setupWebcam():void
		{
			webCam = Camera.getCamera();
			webCam.setMode(WIDTH / 2, HEIGHT / 2, FRAMES_PER_SECOND);
		}
		
		private function setupWebcamDisplay():void
		{
			webcamDisplay = new Video();
			webcamDisplay.width = WIDTH;
			webcamDisplay.height = HEIGHT;
			webcamDisplay.attachCamera(webCam);
			addChildAt(webcamDisplay, getChildIndex(viewport));
			
			capture = new BitmapData(webcamDisplay.width, webcamDisplay.height, false, 0x0);
			thresholdBitmapData = capture.clone();
			
//			thresholdBitmap = new Bitmap(thresholdBitmapData); 
//			addChild(thresholdBitmap); 
//			thresholdBitmap.x = 640; 
//			thresholdBitmap.scaleX = thresholdBitmap.scaleY = 0.5; 
			capture.draw(webcamDisplay);
			
			raster = new FLARRgbRaster_BitmapData(capture);
			detector = new FLARSingleMarkerDetector(cameraParameters, markerPattern, 80);
		}
		
		private function setupFlar():void
		{
			flarCamera3D = new FLARCamera3D(cameraParameters);
			
			flarBase = new FLARBaseNode();
			scene.addChild(flarBase);

			transformationResult = new FLARTransMatResult();
		}
		
		private function setupPapervision3D():void
		{
			
			// not sure why we're not inline... but this seems to fix it :-) 
			viewport.x = -8; 
			
			var bitmapData:BitmapData = new BitmapData(640, 480, true, 0x000000);
			var material:BitmapMaterial = new BitmapMaterial(bitmapData);
			plane = new Plane(material, WIDTH, HEIGHT);
			plane.rotationY = 180;
			
			plane.scale = .3;
			
			flarBase.addChild(plane);
		}
		
		override protected function onRenderTick(event:Event = null):void
		{
			
			capture.draw(webcamDisplay);
			capture.applyFilter(capture, capture.rect, capture.rect.topLeft,new BlurFilter()); 
			
			counter++; 
			
			var currentThreshold : int; 
			
			if(counter == 3) counter = 0; 
						
			var imageFound : Boolean = false
			
			currentThreshold = threshold+ (((counter%3)-1)*thresholdVariance);
			currentThreshold = (currentThreshold>255) ? 255 : (currentThreshold<0) ? 0 : currentThreshold; 
		
			
			imageFound = (detector.detectMarkerLite(raster, currentThreshold) && detector.getConfidence() > 0.5) ;
			
			thresholdBitmapData.fillRect(capture.rect, 0x000000); 
			thresholdBitmapData.threshold(capture,capture.rect, capture.rect.topLeft, '<=', currentThreshold, 0xffffffff, 0xff);
		
			
			if(imageFound) 
			{
				detector.getTransformMatrix(transformationResult);
//				flarBase.setTransformMatrix(transformationResult);
				
				var m:Matrix3D = flarBase.transform;
				var r:FLARTransMatResult = transformationResult;
				var speed:Number = .9;
				
				m.n11 +=  (r.m01 - m.n11) * speed; 
				m.n12 +=  (r.m00 - m.n12) * speed; 
				m.n13 +=  (r.m02 - m.n13) * speed; 
				m.n14 +=  (r.m03 - m.n14) * speed;
				m.n21 += (-r.m11 - m.n21) * speed; 
				m.n22 += (-r.m10 - m.n22) * speed; 
				m.n23 += (-r.m12 - m.n23) * speed; 
				m.n24 += (-r.m13 - m.n24) * speed;
				m.n31 +=  (r.m21 - m.n31) * speed; 
				m.n32 +=  (r.m20 - m.n32) * speed; 
				m.n33 +=  (r.m22 - m.n33) * speed; 
				m.n34 +=  (r.m23 - m.n34) * speed;
				
				flarBase.visible = true;
				threshold = currentThreshold;
				thresholdVariance = 0; 
			} 
			else 
			{
				
				if(counter==2) thresholdVariance +=2; 
				
				if(thresholdVariance>128 ) thresholdVariance = 1; 
			
			}	
			
			plane.material.bitmap.draw(this);
			
			renderer.renderScene(scene, flarCamera3D, viewport);
		}
	}
}