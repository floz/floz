var test:Boolean;
var affiche:Boolean;

var p1x:Number = 0;
var p1y:Number = 0;
var p2x:Number = 0;
var p2y:Number = 0;

var s:Shape = new Shape();
addChild( s );

var result:Sprite = new Sprite();
result.x = stage.stageWidth * .5;
result.y = stage.stageHeight * .5;
addChild( result );

stage.addEventListener( MouseEvent.CLICK, onClick );

function onClick( e:MouseEvent ):void
{
	if( !test )
	{		
		p1x = stage.mouseX;
		p1y = stage.mouseY;
		
		s.graphics.clear();
		s.graphics.lineStyle( 1, 0x000000 );
		s.graphics.moveTo( p1x, p1y );
		
		test = true;
		
		addEventListener( Event.ENTER_FRAME, onFrame );
	}
	else
	{
		removeEventListener( Event.ENTER_FRAME, onFrame );
		
		p2x = stage.mouseX;
		p2y = stage.mouseY;
		
		s.graphics.clear();
		s.graphics.lineStyle( 1, 0x000000 );
		s.graphics.moveTo( p1x, p1y );
		s.graphics.lineTo( p2x, p2y );
		
		test = false;
		
		drawSegment( p1x, p1y, p2x, p2y, Math.atan2( p2y - p1y, p2x - p1x ) );
	}
}

function onFrame( e:Event ):void
{
	s.graphics.clear();
	s.graphics.lineStyle( 1, 0x000000 );
	s.graphics.moveTo( p1x, p1y );
	s.graphics.lineTo( stage.mouseX, stage.mouseY );
}

function drawSegment( x1:Number, y1:Number, x2:Number, y2:Number, a:Number ):void
{
	while( result.numChildren ) result.removeChildAt( 0 );
	
	x2 = x2 - x1;
	y2 = y2 - y1;
	
	x1 =
	y1 = 0;
	
	var r:Number = Math.sqrt( x2 * x2 + y2 * y2 );
	
	var px:Number = r * Math.cos( a );
	var py:Number = r * Math.sin( a );
	
	var g:Graphics = result.graphics;
	g.clear();
	g.lineStyle( 1, 0x000000 );
	g.moveTo( x1, y1 );
	g.lineTo( px, py );
	g.endFill();
	
	var c:MovieClip = new Circle();
	c.x = ( x2 - x1 ) * .5;
	c.y = ( y2 - y1 ) * .5;
	result.addChild( c );
}
