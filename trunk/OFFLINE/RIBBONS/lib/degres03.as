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

var s:Shape = new Shape();
addChild( s );

var result:Sprite = new Sprite();
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
	s.graphics.clear();

	var dx:Number = x2 - x1;
	var dy:Number = y2 - y1;
	var diametre:Number = Math.sqrt( dx * dx + dy *dy );
	var rayon:Number = diametre * .5;
	
	var g:Graphics = result.graphics;
	g.lineStyle( 1, 0x000000 );
	g.moveTo( x1, y1 );
	g.lineTo( x2, y2 );
	g.endFill();
	
	g.lineStyle( 1, 0xbbbbbb );
	g.moveTo( x1, y1 );
	g.lineTo( diametre + x1, y1 );
	g.endFill();
	
	g.lineStyle( 1, 0x00ff00 );
	g.drawCircle( x1, y1, diametre );
	g.endFill();
	
	var ox:Number = x1 + rayon;
	var oy:Number = y1;
	
	g.lineStyle( 1, 0x00ff00 );
	g.drawCircle( ox, oy, rayon );
	g.endFill();
	
	var posX:Number = Math.cos( toRadians( 40 ) ) * rayon;
	var posY:Number = Math.sin( toRadians( 40 ) ) * rayon;
	
	g.lineStyle( 1, 0x0000ff );
	g.moveTo( -posX + ox, -posY + oy );
	g.lineTo( posX + ox, -posY + oy );
	g.lineTo( posX + ox, posY + oy );
	g.lineTo( -posX + ox, posY + oy );
	g.lineTo( -posX + ox, -posY + oy );
	g.endFill();
	
	ox = x1 + dx * .5;
	oy = y1 + dy * .5;
	
	g.lineStyle( 1, 0x00ff00 );
	g.drawCircle( ox, oy, rayon );
	g.endFill();
	
	g.lineStyle( 1, 0x0000ff );
	g.beginFill( Math.random() * 0xffffff, .9 );
	g.moveTo( rayon * Math.cos( Math.atan2( -posY, -posX ) + a ) + ox, rayon * Math.sin( Math.atan2( -posY, -posX ) + a ) + oy );
	g.lineTo( rayon * Math.cos( Math.atan2( posY, -posX ) + a ) + ox, rayon * Math.sin( Math.atan2( posY, -posX ) + a ) + oy );
	g.lineTo( rayon * Math.cos( Math.atan2( posY, posX ) + a ) + ox, rayon * Math.sin( Math.atan2( posY, posX ) + a ) + oy );
	g.lineTo( rayon * Math.cos( Math.atan2( -posY, posX ) + a ) + ox, rayon * Math.sin( Math.atan2( -posY, posX ) + a ) + oy );
	g.lineTo( rayon * Math.cos( Math.atan2( -posY, -posX ) + a ) + ox, rayon * Math.sin( Math.atan2( -posY, -posX ) + a ) + oy );
	g.endFill();
	
	// cercles
	
	var c1:MovieClip = new Circle();
	c1.x = dx * .5 + x1;
	c1.y = dy * .5 + y1;
	addChild( c1 );
	
	var c2:MovieClip = new Circle();
	c2.x = x1 + rayon;
	c2.y = y1;
	addChild( c2 );
}
