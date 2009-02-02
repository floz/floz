<?php
    header('Content-Type: text/xml;charset=utf-8');
    $base = strtolower(substr($_SERVER['SERVER_PROTOCOL'], 0, strrpos($_SERVER['SERVER_PROTOCOL'], '/'))) . '://' . $_SERVER['SERVER_NAME'] . substr($_SERVER['PHP_SELF'], 0, strrpos($_SERVER['PHP_SELF'], '/'));
    
    switch($_GET['swfaddress']) {
        case '/': 
            echo('LOL');
            break;
        case '/test1/': 
            echo('TESTET');
            break;
        case '/Test2/':
            echo('<p>Fusce at ipsum vel diam ullamcorper convallis. Morbi aliquet cursus lacus. Nunc nisi ligula, accumsan sit amet, condimentum nec, ullamcorper a, lectus. Vestibulum ut lectus. Ut rutrum mi nec lectus. Morbi quis nibh. Pellentesque congue, lorem quis porta tincidunt, tellus tortor venenatis leo, vel porttitor massa massa nec dui. In interdum euismod magna. In hac habitasse platea dictumst. Donec erat. Donec nunc ipsum, lobortis ac, feugiat sit amet, vehicula et, tellus. Donec in lacus ac metus condimentum gravida. Duis vehicula. In a neque in purus hendrerit molestie. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>');
            break;
        case '/Test3/':
            echo('<p><img src="' . $base . '/images/1.png" alt="Portfolio 1" width="400" height="300" /><br />');
            echo((isset($_GET['desc']) && $_GET['desc'] == 'true') ? 'Atlantic Hit Mix Calendar<br />' : '');
            echo((isset($_GET['year']) && $_GET['year'] != '') ? $_GET['year'] . '<br />' : '');
            echo('<br /><a href="http://www.sergeevstudio.com">Photos by Lyubomir Sergeev</a></p>');
            break;
        case '/Test4':
            echo('<p><img src="' . $base . '/images/3.png" alt="Portfolio 3" width="400" height="300" /><br />');
            echo((isset($_GET['desc']) && $_GET['desc'] == 'true') ? 'Atlantic Hit Mix Calendar<br />' : '');
            echo((isset($_GET['year']) && $_GET['year'] != '') ? $_GET['year'] . '<br />' : '');
            echo('<br /><a href="http://www.sergeevstudio.com">Photos by Lyubomir Sergeev</a></p>');
            break;
        default:
            echo('<p><!-- Status(404 Not Found) -->Page not found.</p>');
            break;
    }
?>