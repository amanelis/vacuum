(function(f){var d=f.navigator,c=f.document,r=d.userAgent,m="https:"==c.location.protocol?"https://":"http://",n=f.XMLHttpRequest&&"withCredentials"in new XMLHttpRequest;"undefined"!=typeof d.plugins&&"object"==typeof d.plugins["Shockwave Flash"]||f.ActiveXObject&&new ActiveXObject("ShockwaveFlash.ShockwaveFlash");!n&&r.indexOf("MSIE");var q=_vacuum[0][1],s=_vacuum[2][0],t="localhost"==c.location.hostname?m+"localhost:3000/api/v1/errors":m+"www.vacuum.io/api/v1/errors",h={},l="host hostname origin pathname port url href parameters language platform product protocol app_name cookie_enabled user_agent window_event browser_time browser_time_zone app_code_name app_version java_enabled vendor charset referrer remote_addr screen_height screen_width cookies message file line level".split(" "),
b=function(a){_config=a||{};a={debug:!1};for(var g in a)a.hasOwnProperty(g)&&(_config.hasOwnProperty(g)||(_config[g]=a[g]));this.config=_config;this.uuid=this.generate_uuid();this.logger("initialized","true")};b.prototype.uuid=null;b.prototype.blackbox="";b.prototype.handle_error=function(a,g,c,e){h.message=a;h.file=g;h.line=c;h.level=e};b.prototype.logger=function(a,g){if("undefined"===typeof g)return!1;this.config.debug&&console.log("Vacuum["+q+"]["+a+"]["+g+"]")};b.prototype.setCookie=function(a,
g){if("undefined"===typeof a||"undefined"===typeof g)return!1;var b=new Date;b.setFullYear(b.getFullYear()+10);c.cookie=a+"="+g+";expires="+b.toGMTString()+";path=/";return!0};b.prototype.getCookie=function(a){for(var g=c.cookie.split(";"),b=0;b<g.length;b++){var e=g[b].trim().split("=");if(0==a.localeCompare(e[0].trim()))return e[1]}return null};b.prototype.generate_uuid=function(){return Math.floor(4294967296*(1+Math.random())).toString(16)+Math.floor(4294967296*(1+Math.random())).toString(16)+
Math.floor(4294967296*(1+Math.random())).toString(16)+(new Date).getTime()};b.prototype.serialize=function(a){var b=[];for(p in a)b.push(encodeURIComponent(p)+"="+encodeURIComponent(a[p]));return b.join("&")};b.prototype.remote_address=function(){_xmlhttp=f.XMLHttpRequest?new XMLHttpRequest:new ActiveXObject("Microsoft.XMLHTTP");_xmlhttp.open("GET","http://api.hostip.info/get_html.php",!1);_xmlhttp.send();_hostipInfo=_xmlhttp.responseText.split("\n");for(var a=0;_hostipInfo.length>=a;a++)if(_ipAddress=
_hostipInfo[a].split(":"),"IP"==_ipAddress[0])return _ipAddress[1];return!1};b.prototype.captureData=function(){var a={api_key:q};a.app_code_name=d.appCodeName;a.app_name=d.appName;a.app_version=d.appVersion;a.browser_time=new Date;a.browser_time_zone=(new Date).getTimezoneOffset();a.charset=c.charset;a.cookie_enabled=d.cookieEnabled;a.cookies=c.cookie;a.href=f.location.href;a.host=c.location.host;a.hostname=c.location.hostname;a.java_enabled=d.javaEnabled();a.language=d.language;a.origin=c.location.origin;
a.pathname=c.location.pathname;a.parameters=f.location.search;a.platform=d.platform;a.port=c.location.port;a.product=d.product;a.protocol=f.location.protocol;a.referrer=c.referrer;a.remote_addr=this.remote_address();a.screen_height=screen.availHeight;a.screen_width=screen.availWidth;a.url=c.location.toString();a.user_agent=d.userAgent;a.vendor=d.vendor;a.window_event=f.event;a.message=h.message;a.level=h.level;a.line=h.line;a.file=h.file;return a};b.prototype.transmit=function(a,b){if(n){var d=this,
e=d.serialize(b),f=new XMLHttpRequest;f.open("POST",a+"?"+e);f.onreadystatechange=function(a){4===f.readyState&&(d.logger("xhr","ready"),201===f.status?d.logger("transmission","success"):d.logger("transmission","failure"))};f.send()}else{e=c.createElement("iframe");c.body.appendChild(e);e.style.display="none";e.contentWindow.name="sum";e=c.createElement("form");e.target="sum";e.action=a;e.method="POST";for(var h=0;h<l.length;h++){var k=c.createElement("input");k.type="hidden";k.name=l[i];k.value=
this.blackbox[l[h]];e.appendChild(k);c.body.appendChild(e)}e.submit()}};b.prototype.run=function(){this.blackbox=this.captureData();this.transmit(t,this.blackbox)};f.Vacuum=b;f.onerror=function(a,c,d){var e=new b({debug:s});e.handle_error(a,c,d,"window");e.run()}})(window);
