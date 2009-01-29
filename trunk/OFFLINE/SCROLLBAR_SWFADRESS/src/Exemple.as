// Custom utilities
function replace(str, find, replace) {
	return str.split(find).join(replace);
}
function toTitleCase(str) {
	return str.substr(0,1).toUpperCase() + str.substr(1);
}
function formatTitle(title) {
	return 'SWFAddress Website' + (title != '/' ? ' / ' + toTitleCase(replace(title.substr(1, title.length - 2), '/', ' / ')) : '');
}
function copyLink() {
	System.setClipboard(url);
}

// Custom animation code
var interval:Number;
function appear(content, value) {
    if (typeof value == 'undefined') {
		value = 0;
	    interval = setInterval(function () {appear(content, value + 1)} , 50);		
	}
	if (value > 100) {
	    clearInterval(interval);
		return;
	}
    content._alpha = value;
}

// Custom context menu
this.menu = new ContextMenu();
this.menu.hideBuiltInItems();
this.menu.customItems.push(new ContextMenuItem('Home...', function(){SWFAddress.setValue('/')}));
this.menu.customItems.push(new ContextMenuItem('About...', function(){SWFAddress.setValue('/about/')}, true));
this.menu.customItems.push(new ContextMenuItem('Portfolio...', function(){SWFAddress.setValue('/portfolio/')}));
this.menu.customItems.push(new ContextMenuItem('Portfolio 1...', function(){SWFAddress.setValue('/portfolio/1/?desc=true&year=2001')}));
this.menu.customItems.push(new ContextMenuItem('Portfolio 2...', function(){SWFAddress.setValue('/portfolio/2/?desc=true')}));
this.menu.customItems.push(new ContextMenuItem('Portfolio 3...', function(){SWFAddress.setValue('/portfolio/3/?desc=false&year=2001')}));
this.menu.customItems.push(new ContextMenuItem('Contact...', function(){SWFAddress.setValue('/contact/')}));
this.menu.customItems.push(new ContextMenuItem('Copy link to clipboard', function() { copyLink() }, true));

// Custom SWFAddress handling
var content:String = null;
var url:String = null;
var title:String = null;

var ds:String = '';
if (_url.indexOf('file://') == -1) {
	ds = _url.substr(0, _url.lastIndexOf('/') + 1) + datasource;
} else {
	ds = 'http://localhost/swfaddress/samples/seo/datasource.php';
}
function handleChange(event:SWFAddressEvent) {
	
	content = null;
	
	var path:String = event.path;
	var parameters:String = '';
	for (var p in event.parameters) {
		parameters += '&' + p + '=' + event.parameters[p];
	}
	
	url = SWFAddress.getBaseURL() + SWFAddress.getValue();
	title = formatTitle(path);
	
	if (_currentframe == 2 && path == '/') {
		play();
	} else {
		var frame = _currentframe;
		gotoAndStop('$' + path);
		if (frame == _currentframe) {
			gotoAndStop('$/error/');
		}
	}
	
	//var xml:XML = new XML();
	//xml.onLoad = function(success:Boolean) {
		// Fix for the poor image support
		//content = replace(this.firstChild.toString(), 'height="300" />', 
			//'height="300" align="left" hspace="0" vspace="0" /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />');
	//}
	//xml.load(ds + '?swfaddress=' + path + parameters);
	
	SWFAddress.setTitle(title);	
}
SWFAddress.addEventListener(SWFAddressEvent.CHANGE, handleChange);
stop();