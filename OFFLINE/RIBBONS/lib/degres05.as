// Frame label "formules & repères"

function toDegres( value:Number ):Number
{
	return ( value * 180 / Math.PI );
}

function toRadians( value:Number ):Number
{
	return ( value * Math.PI / 180 );
}

function drawRepere( r:Shape ):void
{
	r.graphics.lineStyle( 1, 0x00FF00 );
	r.graphics.moveTo( 0, -100 );
	r.graphics.lineTo( 0, 100 );
	r.graphics.endFill();
	r.graphics.lineStyle( 1, 0x00FF00 );
	r.graphics.moveTo( -100, 0 );
	r.graphics.lineTo( 100, 0 );
	r.graphics.endFill();
}

// Frame label "process"

var test:Boolean;
var affiche:Boolean;

var p1x:Number = 0;
var p1y:Number = 0;
var p2x:Number = 0;
var p2y:Number = 0;

var link1x:Number;
var link1y:Number;
var link2x:Number;
var link2y:Number;

var radians:Number = 0;

var s:Shape = new Shape();
addChild( s );

var result:Sprite = new Sprite();
addChild( result );

result.mouseChildren =
result.mouseEnabled = false;

stage.addEventListener( MouseEvent.CLICK, onClick );

function onClick( e:MouseEvent ):void
{
	if( !test )
	{		
		p1x = stage.mouseX;
		p1y = stage.mouseY;
		
		s.graphics.clear();
		s.graphics.lineStyle( 1, 0xbbbbbb );
		s.graphics.moveTo( p1x, p1y );
		
		test = true;
		
		addEventListener( Event.ENTER_FRAME, onFrame );
	}
	else
	{
		removeEventListener( Event.ENTER_FRAME, onFrame );
		
		test = false;
	}
}

function onFrame( e:Event ):void
{
	p2x = stage.mouseX;
	p2y = stage.mouseY;
	
	drawSegment( p1x, p1y, p2x, p2y, Math.atan2( p2y - p1y, p2x - p1x ) );
				
	p1x = p2x;
	p1y = p2y;
}

function drawSegment( x1:Number, y1:Number, x2:Number, y2:Number, a:Number ):void
{
	s.graphics.clear();
	
	var dx:Number = x2 - x1;
	var dy:Number = y2 - y1;
	var diametre:Number = Math.sqrt( dx * dx + dy *dy );
	var rayon:Number = diametre * .5;	

	var g:Graphics = result.graphics;
	
	var posX:Number = Math.cos( toRadians( 30 ) ) * rayon;
	var posY:Number = Math.sin( toRadians( 30 ) ) * rayon;
	
	var ox:Number = x1 + dx * .5;
	var oy:Number = y1 + dy * .5;
	
	g.lineStyle( 1, 0x0000ff );
	g.moveTo( link2x ? link2x : rayon * Math.cos( Math.atan2( -posY, -posX ) + a ) + ox, link2y ? link2y : rayon * Math.sin( Math.atan2( -posY, -posX ) + a ) + oy );
	g.lineTo( link1x ? link1x : rayon * Math.cos( Math.atan2( posY, -posX ) + a ) + ox, link1y ? link1y : rayon * Math.sin( Math.atan2( posY, -posX ) + a ) + oy );
	g.lineTo( rayon * Math.cos( Math.atan2( posY, posX ) + a ) + ox, rayon * Math.sin( Math.atan2( posY, posX ) + a ) + oy );
	g.lineTo( rayon * Math.cos( Math.atan2( -posY, posX ) + a ) + ox, rayon * Math.sin( Math.atan2( -posY, posX ) + a ) + oy );
	g.lineTo( link2x ? link2x : rayon * Math.cos( Math.atan2( -posY, -posX ) + a ) + ox, link2y ? link2y : rayon * Math.sin( Math.atan2( -posY, -posX ) + a ) + oy );
	g.endFill();

	link1x = rayon * Math.cos( Math.atan2( posY, posX ) + a ) + ox;
	link1y = rayon * Math.sin( Math.atan2( posY, posX ) + a ) + oy;
	
	link2x = rayon * Math.cos( Math.atan2( -posY, posX ) + a ) + ox;
	link2y = rayon * Math.sin( Math.atan2( -posY, posX ) + a ) + oy;
}