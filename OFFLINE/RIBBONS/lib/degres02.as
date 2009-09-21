// Frame label "repères"

stop();

var repere1:Shape = new Shape();
repere1.x = 125;
repere1.y = 150;
drawRepere( repere1 );
addChild( repere1 );

var repere2:Shape = new Shape();
repere2.x = 375;
repere2.y = 150;
drawRepere( repere2 );
addChild( repere2 );

var cnt1:Sprite = new Sprite();
cnt1.x = repere1.x;
cnt1.y = repere1.y;
addChild( cnt1 );

var cnt2:Sprite = new Sprite();
cnt2.x = repere2.x;
cnt2.y = repere2.y;
addChild( cnt2 );

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

// Frame label

var x1:Number = -30;
var y1:Number = -45;
var x2:Number = 30;
var y2:Number = 45;

var rayon:Number = Math.sqrt( x2 * x2 + y2 * y2 );

//

var rect1:Shape = new Shape();
cnt1.addChild( rect1 );

var g:Graphics = rect1.graphics;
g.lineStyle( 1, 0x000000 );
g.moveTo( x1, y1 );
g.lineTo( x2, y1 );
g.lineTo( x2, y2 );
g.lineTo( x1, y2 );
g.lineTo( x1, y1 );
g.endFill();

g.lineStyle( 1, 0xff0000 );
g.drawCircle( 0, 0, rayon );
g.endFill();

g.lineStyle( 1, 0x0000ff );
g.moveTo( 0, 0 );
g.lineTo( rayon * Math.cos( Math.atan2( y1, x1 ) ), rayon * Math.sin( Math.atan2( y1, x1 ) ) );
g.endFill();

var rect2:Shape = new Shape();
cnt2.addChild( rect2 );

var degres:Number = 0;
var radians:Number = toRadians( degres );

build1();

stage.addEventListener( MouseEvent.CLICK, onClick );

function onClick( e:MouseEvent ):void
{
	degres += 10;
	radians = toRadians( degres );
	
	build1();
}

// ok !
function build1():void
{
	g = rect2.graphics;
	g.lineStyle( 0x000000 );
	g.moveTo( rayon * Math.cos( Math.atan2( y1, x1 ) + radians ), rayon * Math.sin( Math.atan2( y1, x1 ) + radians ) );
	g.lineTo( rayon * Math.cos( Math.atan2( y1, x2 ) + radians ), rayon * Math.sin( Math.atan2( y1, x2 ) + radians ) );
	g.lineTo( rayon * Math.cos( Math.atan2( y2, x2 ) + radians ), rayon * Math.sin( Math.atan2( y2, x2 ) + radians ) );
	g.lineTo( rayon * Math.cos( Math.atan2( y2, x1 ) + radians ), rayon * Math.sin( Math.atan2( y2, x1 ) + radians ) );
	g.lineTo( rayon * Math.cos( Math.atan2( y1, x1 ) + radians ), rayon * Math.sin( Math.atan2( y1, x1 ) + radians ) );
	g.endFill();
}

// ok !
function build2():void
{
	g = rect2.graphics;
	g.lineStyle( 0x000000 );
	g.moveTo( Math.cos( radians ) * x1 - Math.sin( radians ) * y1, Math.sin( radians ) * x1 + Math.cos( radians ) * y1 );
	g.lineTo( Math.cos( radians ) * x2 - Math.sin( radians ) * y1, Math.sin( radians ) * x2 + Math.cos( radians ) * y1 );
	g.lineTo( Math.cos( radians ) * x2 - Math.sin( radians ) * y2, Math.sin( radians ) * x2 + Math.cos( radians ) * y2 );
	g.lineTo( Math.cos( radians ) * x1 - Math.sin( radians ) * y2, Math.sin( radians ) * x1 + Math.cos( radians ) * y2 );
	g.lineTo( Math.cos( radians ) * x1 - Math.sin( radians ) * y1, Math.sin( radians ) * x1 + Math.cos( radians ) * y1 );
	g.endFill();
}

function toDegres( value:Number ):Number
{
	return ( value * 180 / Math.PI );
}

function toRadians( value:Number ):Number
{
	return ( value * Math.PI / 180 );
}
