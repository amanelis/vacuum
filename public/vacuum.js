/**
 * Top level namespace for Vacuum.
 *
 * @namespace
 */
var vacuum = {};
var isCommonJS = typeof window == "undefined";
if (isCommonJS) exports.vacuum = vacuum;

/**
 * Use <code>vacuum.undefined</code> instead of <code>undefined</code>, since <code>undefined</code> is just
 * a plain old variable and may be redefined by somebody else.
 *
 * @private
 */
vacuum.undefined = vacuum.___undefined___;

/**
 * Show diagnostic messages in the console if set to true
 */
vacuum.VERBOSE = false;

/**
 * API key - this will be set by user
 */
vacuum.api_key = null;

/** 
  API URL of the server that accepts the log
 */
vacuum.api_url = 'http://localhost:3000'

/**
 * API Path of the log method
 */
vacuum.log_path = '/api/v1/projects';

/**
 * Full error coverage
 */
vacuum.window_error = false;

/**
 * Default interval in milliseconds for event loop yields (e.g. to allow network activity or to refresh the screen with the HTML-based runner). 
 * Small values here may result in slow test running. Zero means no updates until all tests have completed.
 */
vacuum.DEFAULT_UPDATE_INTERVAL = 250;

/**
 * Default timeout interval in milliseconds for waitsFor() blocks.
 */
vacuum.DEFAULT_TIMEOUT_INTERVAL = 5000;

/**
 * @private
 */
vacuum.unimplementedMethod_ = function() {
  throw new Error("unimplemented method");
};

/**
 * Check the status of vacuum is ready to log errors
 */
vacuum.status = function() {
  if ((this.api_key === null || this.api_key === '' || typeof this.api_key === 'undefined') ||
     (this.log_path === null || this.log_path === '' || typeof this.log_path === 'undefined') ||
     (this.api_url === null || this.api_url === '' || typeof this.api_url === 'undefined')) {
    return " == Error initializing vacuum";
  } else {
    return " == Vaccum is ready";
  }
};

/**
 Browser agnostic XMLHttpRequests
 */
vacuum.XMLHttpFactories = [
  function () {return new XMLHttpRequest()},
  function () {return new ActiveXObject("Msxml2.XMLHTTP")},
  function () {return new ActiveXObject("Msxml3.XMLHTTP")},
  function () {return new ActiveXObject("Microsoft.XMLHTTP")}
];

/** 
 * AJAX setup to create request object
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
 * default function for posting erros
 */
vacuum.post_request = function(level, message) {
  var request = vacuum.createXMLHTTPObject();
  var params  = "&amp;message=" + escape(message) + 
                "&amp;level=" + escape(level) + 
                "&amp;parent_url=" + escape(document.location.href) +
                "&amp;user_agent=" + escape(navigator.userAgent) +
                "&amp;platform=" + escape(navigator.platform) +
                "&amp;app_name=" + escape(navigator.appName) +
                "&amp;parameters=" + escape(window.location.search) +
                "&amp;cookie_enabled=" + escape(navigator.cookieEnabled);
    
  if ((level != null || level != "") && (message != null || message != "")) {
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
 * only enable this if the user sets for full error debugging
 */
window.onerror = function(errorMessage, url, line) {
  var params = "&amp;?description=" + escape(errorMessage)
      + "&amp;url="             + escape(url)
      + "&amp;line="            + escape(line)
      + "&amp;parent_url="      + escape(document.location.href)
      + "&amp;user_agent="      + escape(navigator.userAgent)
      + "&amp;app_name="        + escape(navigator.appName) 
      + "&amp;parameters="      + escape(window.location.search)
      + "&amp;cookie_enabled="  + escape(navigator.cookieEnabled)
      + "&amp;message="         + escape(errorMessage) 
      + "&amp;level="           + escape('window')
      + "&amp;platform="        + escape(navigator.platform)
      + "&amp;cookie_enabled="  + escape(navigator.cookieEnabled);
 
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

/** 
 * Custom error logging function
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
  * Log the data to user's account - this can also be custom
 */
// vacuum.log = function(level, message) {
//   var parameters  = "?level=" + escape(level)
//     + "&amp;message="     + escape(message)
//     + "&amp;url="         + escape(document.location.href)
//     + "&amp;user_agent="  + escape(navigator.userAgent)
//     + "&amp;api_key="     + this.api_key;
//   new Image().src = this.api_url + this.log_path + parameters;
// };







// 
// 
// 
// vacuum.BrowserDetect = function() {
//  init: function () {
//    this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
//    this.version = this.searchVersion(navigator.userAgent)
//      || this.searchVersion(navigator.appVersion)
//      || "an unknown version";
//    this.OS = this.searchString(this.dataOS) || "an unknown OS";
//  },
//  searchString: function (data) {
//    for (var i=0;i<data.length;i++) {
//      var dataString = data[i].string;
//      var dataProp = data[i].prop;
//      this.versionSearchString = data[i].versionSearch || data[i].identity;
//      if (dataString) {
//        if (dataString.indexOf(data[i].subString) != -1)
//          return data[i].identity;
//      }
//      else if (dataProp)
//        return data[i].identity;
//    }
//  },
//  searchVersion: function (dataString) {
//    var index = dataString.indexOf(this.versionSearchString);
//    if (index == -1) return;
//    return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
//  },
//  dataBrowser: [
//    {
//      string: navigator.userAgent,
//      subString: "Chrome",
//      identity: "Chrome"
//    },
//    {   string: navigator.userAgent,
//      subString: "OmniWeb",
//      versionSearch: "OmniWeb/",
//      identity: "OmniWeb"
//    },
//    {
//      string: navigator.vendor,
//      subString: "Apple",
//      identity: "Safari",
//      versionSearch: "Version"
//    },
//    {
//      prop: window.opera,
//      identity: "Opera",
//      versionSearch: "Version"
//    },
//    {
//      string: navigator.vendor,
//      subString: "iCab",
//      identity: "iCab"
//    },
//    {
//      string: navigator.vendor,
//      subString: "KDE",
//      identity: "Konqueror"
//    },
//    {
//      string: navigator.userAgent,
//      subString: "Firefox",
//      identity: "Firefox"
//    },
//    {
//      string: navigator.vendor,
//      subString: "Camino",
//      identity: "Camino"
//    },
//    {   // for newer Netscapes (6+)
//      string: navigator.userAgent,
//      subString: "Netscape",
//      identity: "Netscape"
//    },
//    {
//      string: navigator.userAgent,
//      subString: "MSIE",
//      identity: "Explorer",
//      versionSearch: "MSIE"
//    },
//    {
//      string: navigator.userAgent,
//      subString: "Gecko",
//      identity: "Mozilla",
//      versionSearch: "rv"
//    },
//    {     // for older Netscapes (4-)
//      string: navigator.userAgent,
//      subString: "Mozilla",
//      identity: "Netscape",
//      versionSearch: "Mozilla"
//    }
//  ],
//  dataOS : [
//    {
//      string: navigator.platform,
//      subString: "Win",
//      identity: "Windows"
//    },
//    {
//      string: navigator.platform,
//      subString: "Mac",
//      identity: "Mac"
//    },
//    {
//         string: navigator.userAgent,
//         subString: "iPhone",
//         identity: "iPhone/iPod"
//      },
//    {
//      string: navigator.platform,
//      subString: "Linux",
//      identity: "Linux"
//    }
//  ]
// 
// };