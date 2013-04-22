(function(window) {
  /**
   * Saved references so that closure compiler can minimize file size.
   */
  var ArrayProto      = Array.prototype
    , ObjProto        = Object.prototype
    , slice           = ArrayProto.slice
    , toString        = ObjProto.toString
    , hasOwnProperty  = ObjProto.hasOwnProperty
    , windowConsole   = window.console
    , navigator       = window.navigator
    , document        = window.document
    , userAgent       = navigator.userAgent;

  /*
   * Constants
   */
  var /** @const */ PRIMARY_INSTANCE_NAME = "vacuum"
    , /** @const */ NAMESPACE_NAME        = "vacuum"
    , /** @const */ SESSION_F_NAME        = "_vacuum_uuid_f"
    , /** @const */ SESSION_C_NAME        = "_vacuum_uuid_c"
    , /** @const */ SET_QUEUE_KEY         = "__sps"
    , /** @const */ ADD_QUEUE_KEY         = "__spa"
    , /** @const */ APPEND_QUEUE_KEY      = "__spap"
    , /** @const */ SET_ACTION            = "$set"
    , /** @const */ ADD_ACTION            = "$add"
    , /** @const */ APPEND_ACTION         = "$append"
    , /** @const */ ALIAS_ID_KEY          = "__alias"
    , /** @const */ RESERVED_PROPERTIES   = [SET_QUEUE_KEY, ADD_QUEUE_KEY, APPEND_QUEUE_KEY, ALIAS_ID_KEY];

  /*
   * Dynamic configured constants.
   */
  var /** @const */ HTTP_PROTOCOL    = (("https:" == document.location.protocol) ? "https://" : "http://")
    , /** @const */ USE_XHR          = (window.XMLHttpRequest && 'withCredentials' in new XMLHttpRequest())
    , /** @const */ USE_FLASH        = ((typeof navigator.plugins != "undefined" && typeof navigator.plugins["Shockwave Flash"] == "object") || (window.ActiveXObject && (new ActiveXObject("ShockwaveFlash.ShockwaveFlash")) != false))
    , /** @const */ ENQUEUE_REQUESTS = !USE_XHR && (userAgent.indexOf('MSIE') == -1)
    , /** @const */ API_KEY          = _vacuum[0][1]
    , /** @const */ API_URL          = document.location.hostname == 'localhost' ? HTTP_PROTOCOL + 'localhost:3000/logger' : HTTP_PROTOCOL + 'vacuum.io/api/v1/errors'
    , /** @const */ FLA_TIMEOUT      = 5
    , /** @const */ CURRENT_DOMAIN   = document.location.host
    , /** @const */ VARIABLE_DRIVERS = ['host', 'hostname', 'origin', 'pathname', 'port',
                                        'url', 'href', 'parameters', 'language', 'platform',
                                        'product', 'protocol', 'app_name', 'cookie_enabled',
                                        'user_agent', 'window_event', 'browser_time',
                                        'browser_time_zone', 'app_code_name', 'app_version',
                                        'java_enabled', 'vendor', 'charset', 'referrer',
                                        'remote_addr', 'screen_height', 'screen_width', 'cookies'
                                        'message', 'file', 'line', 'level'];

    /**
     * @constructor
     * @param {object} hash Provide a hash of custom configuration options
     */
    var Vacuum = function(config) {
      _config = config || {};
      var _defaults = {
        debug: false
      };
      var _key;
      for(_key in _defaults){
        if(_defaults.hasOwnProperty(_key)){
          if(!_config.hasOwnProperty(_key)){
            _config[_key] = _defaults[_key];
          }
        }
      }
      this.config       = _config;
      this.uuid         = this.generate_uuid();
    };

    /**
     * @implementation
     */

    /**
     * This will hold the Vacuum UUID value. Initialize as nil.
     * @return {string}
     */
    Vacuum.prototype.uuid = null;

    /**
     * String variable for getting setting the params string that will
     * be posted to platform API.
     * @return {string}
     */
    Vacuum.prototype.blackbox = "";

    /**
     * Logger determined by debug mode
     * @param {string} message The message that the logger will log to console.
     */
    Vacuum.prototype.logger = function(message) {
      if (typeof message === 'undefined') return false;
      if (this.config.debug) console.log(message);
    };

    /**
     * Main endpoing to setting a cookie on users domain
     * @param {string} key Name of the cookies key.
     * @param {string} value Value the cookie will hold.
     */
    Vacuum.prototype.setCookie = function(key, value) {
      if (typeof key === 'undefined' || typeof value === 'undefined') return false;

      var _cookieDate = new Date;
      _cookieDate.setFullYear(_cookieDate.getFullYear() +10);
      document.cookie = key +"=" + value + ';expires=' + _cookieDate.toGMTString( ) + ';path=/';
      return true
    };

    /**
     * Getter method for the current cookie by key
     */
    Vacuum.prototype.getCookie = function(key) {
      var _cookies = document.cookie.split(';');

      for (var _i = 0; _i < _cookies.length; _i++) {
          var _cookie = _cookies[_i].trim();
          var _values = _cookie.split('=');

          if (key.localeCompare(_values[0].trim()) == 0) {
              return _values[1];
          }
      }
      return null;
    };

    /**
     * Builds a hexidecimal string for uuid.
     * @return {string} a 40 character hexidecimal string.
     */
    Vacuum.prototype.generate_uuid = function() {
      return Math.floor((1 + Math.random()) * 0x100000000).toString(16) + Math.floor((1 + Math.random()) * 0x100000000).toString(16)
        + Math.floor((1 + Math.random()) * 0x100000000).toString(16) + new Date().getTime();
    };

    /**
     * Serialize a hash into a proper http url query string.
     * @param {object} hash of key value pairs for url encoding
     * @return {string} a urlencoded string that can be used in a HTTP request.
     */
    Vacuum.prototype.serialize = function(obj) {
      var _str = [];
      for(p in obj) { _str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p])); }
      return _str.join("&");
    };

    /**
     * Attempts to get the IP Address of the client.
     * @return {?string}
     */
    Vacuum.prototype.remote_address = function() {
      if (window.XMLHttpRequest) _xmlhttp = new XMLHttpRequest();
      else _xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");

      _xmlhttp.open("GET","http://api.hostip.info/get_html.php",false);
      _xmlhttp.send();

      _hostipInfo = _xmlhttp.responseText.split("\n");

      for (var _i=0; _hostipInfo.length >= _i; _i++) {
          _ipAddress = _hostipInfo[_i].split(":");
          if ( _ipAddress[0] == "IP" ) return _ipAddress[1];
      }
      return false;
    };

    /**
     * Capture device/browser information. Each key of the data hash
     * must match one in VARIABLE_DRIVERS.
     * @return {object}
     */
    Vacuum.prototype.captureData = function() {
      var _data = new Object();
      _data['api_key']           = API_KEY;

      /* Defaults, must match VARIABLE_DRIVERS */
      _data['app_code_name']     = navigator.appCodeName;
      _data['app_name']          = navigator.appName;
      _data['app_version']       = navigator.appVersion;
      _data['browser_time']      = new Date();
      _data['browser_time_zone'] = new Date().getTimezoneOffset();
      _data['charset']           = document.charset;
      _data['cookie_enabled']    = navigator.cookieEnabled;
      _data['cookies']           = document.cookie;
      _data['href']              = window.location.href;
      _data['host']              = document.location.host;
      _data['hostname']          = document.location.hostname;
      _data['java_enabled']      = navigator.javaEnabled();
      _data['language']          = navigator.language;
      _data['origin']            = document.location.origin;
      _data['pathname']          = document.location.pathname;
      _data['parameters']        = window.location.search;
      _data['platform']          = navigator.platform;
      _data['port']              = document.location.port;
      _data['product']           = navigator.product;
      _data['protocol']          = window.location.protocol;
      _data['referrer']          = document.referrer;
      _data['remote_addr']       = this.remote_address();
      _data['screen_height']     = screen.availHeight;
      _data['screen_width']      = screen.availWidth;
      _data['url']               = document.location.toString();
      _data['user_agent']        = navigator.userAgent;
      _data['vendor']            = navigator.vendor;
      _data['window_event']      = window.event;
      /* Defaults, must match VARIABLE_DRIVERS */

      return _data;
    };

    /**
     * Transmission for the data to server via a hidden form inserted into an iframe
     * if XHR is unavailable. If it is, well use an XHR request via POST.
     * @param {string} url The url that the data will be sent to.
     * @param {string} hash The object that will have to be encoded to url friendly text.
     * @return {boolean} successful/not successful if request was made.
     */
    Vacuum.prototype.transmit = function(url, hash) {
      if (USE_XHR) {
        var _self = this;
        var _data = _self.serialize(hash);
        var _xhr  = new XMLHttpRequest();
        _xhr.open('POST', url + "?" + _data);
        _xhr.onreadystatechange = function (e) {
          if (_xhr.readyState === 4) {
            if (_xhr.status === 201) {
            } else {
            }
          }
        };
        _xhr.send();
      } else {
        var _iframe = document.createElement("iframe");
        var _uniqueNameOfFrame = "sum";
        document.body.appendChild(_iframe);
        _iframe.style.display = "none";
        _iframe.contentWindow.name = _uniqueNameOfFrame;

        var _form = document.createElement("form");
        _form.target = _uniqueNameOfFrame;
        _form.action = url;
        _form.method = "POST";

        for (var _i = 0; _i < VARIABLE_DRIVERS.length; _i++) {
          var _input = document.createElement("input");
          _input.type = "hidden";
          _input.name = VARIABLE_DRIVERS[i];
          _input.value = this.blackbox[VARIABLE_DRIVERS[_i]];
          _form.appendChild(_input);
          document.body.appendChild(_form);
        }
        _form.submit();
      }
    };
    
    /**
     * This is the main function that coordinates everything. From here,
     * the first step is to capture all device data. Once that completes,
     * the data is transmitted. Also, the cookie is enabled and set here.
     */
    Vacuum.prototype.record = function() {
      this.blackbox = this.captureData();
      this.transmit(API_URL, this.blackbox);
    };

    /**
     * Append the vacuum to the body of the document for onload. This
     * method will call the record function which will start the recording
     * process of data, transmision and cookies.
     */
    var _init = function() {
      /**
       * New instance of vacuum.
       * TODO: store in window['vacuum']['instances']
       */
      var _vacuum = new Vacuum({
        debug: true
      });

      /**
       * Attach the object to the window's onload method. Once loaded, _vacuum
       * will start the process of collecting and then sending the data.
       */
      if(window.attachEvent) {
        window.attachEvent('onload', _vacuum.record());
      } else {
        if(window.onload) {
          var _curronload = window.onload;
          var _newonload = function() {
            _curronload();
            _vacuum.record();
          };
          window.onload = _newonload;
        } else {
          window.onload = _vacuum.record();
        }
      }
      return _vacuum;
    };

    /**
     * Run and initialize the object, save the object to the window.
     */
    window['vacuum'] = _init();
})(window);