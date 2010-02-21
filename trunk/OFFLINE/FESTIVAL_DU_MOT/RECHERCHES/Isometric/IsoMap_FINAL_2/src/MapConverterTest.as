
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsGradientFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import fr.minuit4.games.tilebased.core.tiles.TileDatas;
	import fr.minuit4.games.tilebased.utils.MapDatasConverter;
	
	public class MapConverterTest extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _datas:Array = [ [ 0, 0, 0, , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0 ],
									 [ 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2 ],
									 [ 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0 ], 
									 [ 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
									 [ 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ];
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MapConverterTest() 
		{
			var v:Vector.<Vector.<TileDatas>> = MapDatasConverter.fromArray( _datas );
			
			//graphics.drawGraphicsData( Vector.<IGraphicsData>( [ new GraphicsSolidFill( 0x00ff00 ) ] ) );
			//graphics.drawRect( 0, 0, 20, 20 );
			//graphics.drawGraphicsData( Vector.<IGraphicsData>( [ new GraphicsStroke( 1 ), new GraphicsSolidFill( 0x00fff0 ) ] ) );
			//graphics.drawRect( 0, 0, 20, 20 );
			
			// establish the fill properties
			var myFill:GraphicsSolidFill = new GraphicsSolidFill();
			myFill.color = 0xff00ff;
			//myFill.colors = [0xEEFFEE, 0x0000FF];
			//myFill.matrix = new Matrix();
			//myFill.matrix.createGradientBox(100, 100, 0);
		 
			// establish the stroke properties
			var myStroke:GraphicsStroke = new GraphicsStroke();
			myStroke.thickness = 5;
			myStroke.fill = new GraphicsSolidFill(0x000000);
		 
			// establish the path properties
			var myPath:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
			myPath.commands.push(1,2,2,2,2);
			myPath.data.push(10,10, 10,100, 100,100, 100,10, 10,10);
		 
			// populate the IGraphicsData Vector array
			var myDrawing:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
			myDrawing.push(myStroke, myFill);
		 
			// render the drawing 
			graphics.drawGraphicsData(myDrawing);
			graphics.drawPath( myPath.commands, myPath.data );

		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}