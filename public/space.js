(function() {
  var spaceship = {};
  if (typeof window == "undefined") exports.spaceship = spaceship;
  
  /**
   * Use <code>spaceship.undefined</code> instead of <code>undefined</code>, since <code>undefined</code> is just
   * a plain old variable and may be redefined by somebody else.
   *
   * @private
   * @param
   * @return Void
   */
  spaceship.undefined = spaceship.___undefined___;
  
  /**
   * Show diagnostic messages in the console if set to true.
   * @param
   * @return Void
   */
  spaceship.VERBOSE = true;
  
  /**
   * Setter for spaceship data. Will be a json formatted String
   * @param
   * @return String[blackbox]
   */
  spaceship.blackbox = "";
  
  /**
   * Setter method for the applications key.
   * @param
   * @return String[api_key]
   */
  spaceship.api_key = _signifyd[0][1];
  
  /**
   * Catch unimplemented methods.
   * @param
   * @return Void
   */
  spaceship.unimplementedMethod_ = function() {
    throw new Error("unimplemented method");
  };
  
  /**
   * Determines if the browser can actually do XHR requests
   * @param
   * @return Boolean
   */
  spaceship.USE_XHR = function() {
    return (window.XMLHttpRequest && 'withCredentials' in new XMLHttpRequest());
  };
  
  /**
   * Logging for Spaceship
   * @param String[message]
   * @return Void
   */
  spaceship.Logger = function(message) {
    if (spaceship.VERBOSE == true) {
      console.log(message);
    }
  };
  
  /**
   * Serialize a hash into a proper http url query string
   * @param Hash[obj]
   * @return String
   */
  spaceship.serialize = function(obj) {
    var str = [];
    for(var p in obj)
      str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
    return str.join("&");
  };
  
  /**
   * Get the remote IP Address of the client
   * @param
   * @return Boolean
   */
  spaceship.remote_address = function() {
    if (window.XMLHttpRequest) xmlhttp = new XMLHttpRequest();
    else xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");

    xmlhttp.open("GET","http://api.hostip.info/get_html.php",false);
    xmlhttp.send();

    hostipInfo = xmlhttp.responseText.split("\n");

    for (i=0; hostipInfo.length >= i; i++) {
        ipAddress = hostipInfo[i].split(":");
        if ( ipAddress[0] == "IP" ) {
          return ipAddress[1];
        }
    }
    return false;
  };
  
  /**
   * These are the actual methods that we are trying to pull from the user agent and data on the user
   * @param
   * @return Array
   */
  spaceship.drivers = function() {
    return [
      'host',
      'hostname',
      'origin',
      'pathname',
      'port',
      'url',
      'href',
      'parameters',
      'language',
      'platform',
      'product',
      'protocol',
      'app_name',
      'cookie_enabled',
      'user_agent',
      'window_event',
      'browser_time',
      'browser_time_zone',
      'app_code_name',
      'app_version',
      'java_enabled',
      'vendor',
      'charset',
      'referrer',
      'remote_addr',
      'screen_height',
      'screen_width'
    ];
  };
  
  /**
   * Capture device information
   * @param
   * @return
   */
  spaceship.captureData = function() {
    var data = new Object();
    data['host']              = document.location.host;
    data['hostname']          = document.location.hostname;
    data['origin']            = document.location.origin;
    data['pathname']          = document.location.pathname;
    data['port']              = document.location.port;
    data['url']               = document.location.toString();
    data['app_code_name']     = navigator.appCodeName;
    data['app_version']       = navigator.appVersion;
    data['java_enabled']      = navigator.javaEnabled();
    data['vendor']            = navigator.vendor;
    data['charset']           = document.charset;
    data['referrer']          = document.referrer;
    data['screen_height']     = screen.availHeight;
    data['screen_width']      = screen.availWidth;
    data['href']              = window.location.href;
    data['parameters']        = window.location.search;
    data['protocol']          = window.location.protocol;
    data['language']          = navigator.language;
    data['platform']          = navigator.platform;
    data['product']           = navigator.product;
    data['app_name']          = navigator.appName;
    data['cookie_enabled']    = navigator.cookieEnabled;
    data['user_agent']        = navigator.userAgent;
    data['window_event']      = window.event;
    data['remote_addr']       = spaceship.remote_address();
    data['browser_time']      = new Date();
    data['browser_time_zone'] = new Date().getTimezoneOffset();

    spaceship.blackbox = data;
  };
  
  /** 
   * Transmission for the data to server via a hidden form inserted into an iframe
   * @param
   * @return
   */
  spaceship.transmit = function(url, text) {
    if (spaceship.USE_XHR) {
      
      var data = spaceship.serialize(text);
      var xhr = new XMLHttpRequest();
      xhr.open('POST', url + "?" + data);
      xhr.onreadystatechange = function (e) {
          if (xhr.readyState === 4) { // XMLHttpRequest.DONE == 4, except in safari 4
              if (xhr.status === 200) {
                spaceship.Logger('xhr success');
              } else {
                spaceship.Logger('xhr failed');
              }
          }
      };
      xhr.send();
    } else {
      var iframe = document.createElement("iframe");
      var uniqueNameOfFrame = "sum";
      document.body.appendChild(iframe);
      iframe.style.display = "none";
      iframe.contentWindow.name = uniqueNameOfFrame;
      
      // construct a form with hidden inputs, targeting the iframe
      var form = document.createElement("form");
      form.target = uniqueNameOfFrame;
      form.action = url;
      form.method = "POST";
      
      for (var i = 0; i < spaceship.drivers().length; i++) { 
        var input = document.createElement("input");
        input.type = "hidden";
        input.name = spaceship.drivers()[i];
        input.value = spaceship.blackbox[spaceship.drivers()[i]];
        form.appendChild(input);
        document.body.appendChild(form);
      }
      
      form.submit();
    }  
  };
  
  /**
   * Execute this funtion onload, gather data and send it off to the servcer.
   * @param
   * @return Void
   */
  spaceship.dvr = function() {
    spaceship.captureData();
    spaceship.transmit('http://localhost:3000/logger/' + spaceship.api_key + '/err', spaceship.blackbox);
  };
   
  /**
   * Append the spaceship to the body of the document for onload. This
   * method will call the dvr function which will start the recording 
   * process of data.
   * @param
   * @return Void
   */
  spaceship.attachToBody = function() {
    if(window.attachEvent) {
      window.attachEvent('onload', spaceship.dvr);
    } else {
      if(window.onload) {
          var curronload = window.onload;
          var newonload = function() {
              curronload();
              spaceship.dvr();
          };
          window.onload = newonload;
      } else {
          window.onload = spaceship.dvr;
      }
    }
  }();
})();
