
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.geom 
{
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	
	public class IsoDrawing 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static const ZERO:Point3D = new Point3D( 0, 0, 0 );
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private static function convertGeometryToDatas( geometry:Vector.<Point3D> ):Vector.<Number>
		{
			var idx:int = -1;
			
			var n:int = geometry.length;
			var data:Vector.<Number> = new Vector.<Number>( n << 1, true );
			for ( var i:int; i < n; ++i )
			{
				data[ ++idx ] = geometry[ i ].x;
				data[ ++idx ] = geometry[ i ].y;
			}
			
			return data;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function drawRect( g:Graphics, width:Number = 0, length:Number = 0, height:Number = 0, origin:Point3D = null ):void
		{
			var gp:GraphicsPath = getRectPath( width, length, height, origin );
			if ( gp ) g.drawPath( gp.commands, gp.data );
		}
		
		public static function getRectPath( width:Number = 0, length:Number = 0, height:Number = 0, origin:Point3D = null ):GraphicsPath
		{
			if ( !origin ) origin = ZERO;
			
			var geometry:Vector.<Point3D> = new Vector.<Point3D>( 5, true );
			geometry[ 0 ] = IsoMath.isoToScreen( new Point3D( origin.x, origin.y, origin.z ) );
			
			if ( width > 0 && length > 0 && height <= 0 )
			{
				geometry[ 1 ] = IsoMath.isoToScreen( new Point3D( origin.x + width, origin.y, origin.z ) );
				geometry[ 2 ] = IsoMath.isoToScreen( new Point3D( origin.x + width, origin.y + length, origin.z ) );
				geometry[ 3 ] = IsoMath.isoToScreen( new Point3D( origin.x, origin.y + length, origin.z ) );
			}
			else if ( width > 0 && length <= 0 && height > 0 )
			{
				geometry[ 1 ] = IsoMath.isoToScreen( new Point3D( origin.x + width, origin.y, origin.z ) );
				geometry[ 2 ] = IsoMath.isoToScreen( new Point3D( origin.x + width, origin.y, origin.z + height ) );
				geometry[ 3 ] = IsoMath.isoToScreen( new Point3D( origin.x, origin.y, origin.z + height ) );
			}
			else if ( width <= 0 && length > 0 && height > 0 )
			{
				geometry[ 1 ] = IsoMath.isoToScreen( new Point3D( origin.x, origin.y + length, origin.z ) );
				geometry[ 2 ] = IsoMath.isoToScreen( new Point3D( origin.x, origin.y + length, origin.z + height ) );
				geometry[ 3 ] = IsoMath.isoToScreen( new Point3D( origin.x, origin.y, origin.z + height ) );
			}
			else return null;
			
			geometry[ 4 ] = geometry[ 0 ].clone();
			
			var commands:Vector.<int> = new Vector.<int>( 5, true );
			commands[ 0 ] = GraphicsPathCommand.MOVE_TO;
			commands[ 1 ] =
			commands[ 2 ] =
			commands[ 3 ] =
			commands[ 4 ] = GraphicsPathCommand.LINE_TO;
			
			return new GraphicsPath( commands, convertGeometryToDatas( geometry ) );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}