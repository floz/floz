/*
This is a super simple test harness to get you started. The final release will have some better demos.
*/
package  {
	
	import flash.display.MovieClip;
	import com.gskinner.performance.*;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import nums.TestNumTypes;
	import singletons.TestSingleton;
	//import tests.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.system.Capabilities;
	
	public class MainPerfTest extends Sprite {
		
		public var outFld:TextField;
		public var loopsMultiple:Number=1;
		
		public function MainPerfTest() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			outFld = new TextField();
			outFld.autoSize = TextFieldAutoSize.LEFT;
			outFld.defaultTextFormat = new TextFormat( "_sans", 12 );
			addChild( outFld );
			
			PerformanceTest.getInstance().delay = 1000;
			outFld.text = "Running tests on "+Capabilities.version+" "+(Capabilities.isDebugger ? "DEBUG" : "RELEASE")+" with loopsMultiple="+loopsMultiple+"...\n";
			new TextLog().out = out;
			new XMLLog().out = out2;
			
			queueTest( new TestSingleton() );
			queueTest( new TestNumTypes() );
			
			//test.addEventListener(Event.COMPLETE, handleTestComplete);
			
			//queueTest(Math.floor, "SampleError", 5, 1000, ["badParam","badParam"]);
			//queueTest(Math.min, "SampleTest", 5, 100000, [20,50]);
			//*
			//queueTest(new Bitwise());
			//queueTest(new CollectionIteration());
			//queueTest(new VectorPopulation());
			//queueTest(new Casting());
			//queueTest(new CastingPromotion());
			//queueTest(new Collections());
			//queueTest(new CollectionSplice());
			//queueTest(new ConditionalPriority());
			//queueTest(new Events());
			//queueTest(new FunctionScope());
			//queueTest(new GraphicsTests());
			//queueTest(new FunctionInlining());
			//queueTest(new Literals());
			//queueTest(new LLConstruction());
			//queueTest(new LLIteration());
			//queueTest(new LoopHoisting());
			//queueTest(new Loops());
			//queueTest(new MultDiv());
			//queueTest(new Scope());
			//queueTest(new StrongTyping());
			//*/
			//queueTest(new TryCatch());
			//queueTest(new VectorIterators());
		}
		
		protected function queueTest(test:*):void {
			if ("loops" in test) {
				test.loops = test.loops*loopsMultiple|0;
			} else {
				out("* Test: "+test.name+" does not have a loops property.");
			}
			PerformanceTest.queue(test);
		}
		
	
		protected function out(str:*):void {
			outFld.appendText(String(str)+"\n");
			outFld.scrollV = outFld.maxScrollV;
		}
		protected function out2(str:*):void {
			outFld.appendText("\n"+String(str)+"\n");
			outFld.scrollV = outFld.maxScrollV;
		}
		
	
		protected function handleTestComplete(evt:Event):void {
			var test:TestSuite = evt.target as TestSuite;
			trace(test.toXML().toXMLString());
		}
	}
}
