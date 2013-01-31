/**
 * **************************************************************************
 * **************************************************************************
 * **************************************************************************
 * **************************************************************************
 * Vacuum.js
 * 1) Include this script after your jquery $(document).ready call
 * 2) Set the api_key:                      vacuum.api_key = 'YOUR KEY';
 * 3) Full coverage:                        vacuum.window_error = true;
 * 4) Turn debugging on:                    vacuum.VERBOSE = true;
 *
 * Manually log requests, data, variables:  vacuum.{warn:error:debug:info:fatal}(String[message])
 *
 * At this point, all errors will be caught.
 */

/**
 * vacuum.{method}
 * @namspace
 */
var vacuum = {};
if (typeof window == "undefined") exports.vacuum = vacuum;

/**
 * Use <code>vacuum.undefined</code> instead of <code>undefined</code>, since <code>undefined</code> is just
 * a plain old variable and may be redefined by somebody else.
 *
 * @private
 * @param
 * @return
 */
vacuum.undefined = vacuum.___undefined___;

/**
 * Show diagnostic messages in the console if set to true
 * @param
 * @return
 */
vacuum.VERBOSE = false;

/**
 * API key - this will be set by user, application should not function without this set
 * @param
 * @return
 */
vacuum.api_key = null;

/**
  * API URL of the server that accepts the log
  * @param
  * @return
 */
vacuum.api_url = window.location.hostname == "" || window.location.hostname == 'localhost' ? 'http://localhost:3000' : 'http://vacuumhq.herokuapp.com';

/**
 * API Path of the log method
 * @param
 * @return
 */
vacuum.log_path = '/api/v1/errors';

/**
 * Full error coverage
 * @param
 * @return
 */
vacuum.window_error = false;

/**
 * Default interval in milliseconds for event loop yields (e.g. to allow network activity or to refresh the screen with the HTML-based runner).
 * Small values here may result in slow test running. Zero means no updates until all tests have completed.
 * @param
 * @return
 */
vacuum.DEFAULT_UPDATE_INTERVAL = 250;

/**
 * Default timeout interval in milliseconds for waitsFor() blocks.
 * @param
 * @return
 */
vacuum.DEFAULT_TIMEOUT_INTERVAL = 5000;

/**
 * Catch unimplemented methods.
 * @param
 * @return
 */
vacuum.unimplementedMethod_ = function() {
  throw new Error("unimplemented method");
};

/**
 * Browser agnostic XMLHttpRequests - these are required to build an ajax request when posting errors
 * @param
 * @return
 */
vacuum.XMLHttpFactories = [
  function () {return new XMLHttpRequest()},
  function () {return new ActiveXObject("Msxml2.XMLHTTP")},
  function () {return new ActiveXObject("Msxml3.XMLHTTP")},
  function () {return new ActiveXObject("Microsoft.XMLHTTP")}
];

/**
 * Main function for returning a users IP address
 *
 * @param
 * @return String || Boolean
 */
vacuum.getClientIP = function() {
    // name of the ip address cookie 'vacuum_user_address'
  
    if (window.XMLHttpRequest) xmlhttp = new XMLHttpRequest();
    else xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");

    xmlhttp.open("GET","http://api.hostip.info/get_html.php",false);
    xmlhttp.send();
    hostipInfo = xmlhttp.responseText.split("\n");

    for (i=0; hostipInfo.length >= i; i++) {
        ipAddress = hostipInfo[i].split(":");
        if ( ipAddress[0] == "IP" ) return ipAddress[1];
    }
    return false;
};

/**
 * Check the status of vacuum is ready to log errors
 * @param
 * @return String
 */
vacuum.status = function() {
  if ((this.api_key === null || this.api_key === '' || typeof this.api_key === 'undefined') ||
     (this.log_path === null || this.log_path === '' || typeof this.log_path === 'undefined') ||
     (this.api_url === null || this.api_url === '' || typeof this.api_url === 'undefined')) {
    return "Vacuum.js -> Error initializing vacuum";
  } else {
    return "Vaccum.js -> ready and loaded";
  }
};

/**
 * AJAX setup to create request object
 * @param
 * @return XMLHttpRequest
 */
vacuum.createXMLHTTPObject = function() {
	var xmlhttp = false;
	for (var i = 0; i < vacuum.XMLHttpFactories.length; i++) {
		try { xmlhttp = vacuum.XMLHttpFactories[i](); }
		catch (e) { continue; }
		break;
	}
	return xmlhttp;
};

/**
 * Manual custom error logging function
 * @param
 * @return 
 */
vacuum.debug = function(message) {
 this.post_request('debug', message);
};
vacuum.error = function(message) {
 this.post_request('error', message);
};
vacuum.fatal = function(message) {
 this.post_request('fatal', message);
};
vacuum.info = function(message) {
 this.post_request('info', message);
};
vacuum.warn = function(message) {
 this.post_request('warn', message);
};

/**
 * Manual method for posting errors
 * @param
 * @return
 */
vacuum.post_request = function(level, message) {
  var request = vacuum.createXMLHTTPObject();
  var params  =   "&amp;level="            + escape(level) +
                  "&amp;message="          + escape(message) +
                  
                  "&amp;href="             + escape(window.location.href) + 
                  "&amp;parameters="       + escape(window.location.search) +
                  "&amp;language="         + escape(navigator.language) + 
                  "&amp;platform="         + escape(navigator.platform) +
                  "&amp;product="          + escape(navigator.product) +
                  "&amp;protocol="         + escape(window.location.protocol) +

                  "&amp;app_name="         + escape(navigator.appName) +
                  "&amp;cookie_enabled="   + escape(navigator.cookieEnabled) +
                  "&amp;user_agent="       + escape(navigator.userAgent) +
                  "&amp;user_address="     + escape('coming soon') +

                  "&amp;window_event="     + escape(window.event) +
                  "&amp;stack_trace="      + escape('coming soon') +

                  "&amp;browers_time="     + escape(new Date());
                  

  if ((level != null || level != "") && (message != null || message != "") && this.api_key != null) {
    request.open('POST', this.api_url + this.log_path + '?api_key=' + this.api_key + params, true);
  	request.setRequestHeader('Content-type','application/x-www-form-urlencoded');
    request.onreadystatechange = function () {
      if (request.readyState != 4) return;
    }
    if (request.readyState == 4) return;
    request.send();
  }
};

/**
 * Automatic error logging.
 * @param
 * @return String
 */
window.onerror = function(message, file, line) { 
  if (!vacuum.window_error) return false;
  var params = "&amp;description=" + escape(message) +
        "&amp;message="          + escape(message) +
        "&amp;file="             + escape(file) +
        "&amp;line="             + escape(line) +
        "&amp;level="            + escape('window') +
        
        "&amp;href="             + escape(window.location.href) + 
        "&amp;parameters="       + escape(window.location.search) +
        "&amp;language="         + escape(navigator.language) + 
        "&amp;platform="         + escape(navigator.platform) +
        "&amp;product="          + escape(navigator.product) +
        "&amp;protocol="         + escape(window.location.protocol) +

        "&amp;app_name="         + escape(navigator.appName) +
        "&amp;cookie_enabled="   + escape(navigator.cookieEnabled) +
        "&amp;user_agent="       + escape(navigator.userAgent) +
        "&amp;user_address="     + escape(vacuum.getClientIP()j) +

        "&amp;window_event="     + escape(window.event) +
        "&amp;stack_trace="      + escape('coming soon') +

        "&amp;browers_time="     + escape(new Date());
  
    /** Send error to server */
    var request = vacuum.createXMLHTTPObject();
    request.open('POST', vacuum.api_url + vacuum.log_path + '?api_key=' + vacuum.api_key + params, true);
    request.setRequestHeader('Content-type','application/x-www-form-urlencoded');
    request.onreadystatechange = function () {
    if (request.readyState != 4) return;
    }
    if (request.readyState == 4) return;
    request.send();  
};
