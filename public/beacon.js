(function () {
    if (window._data && _data.shift) {
        var z = _data.shift();
        for (var p = "https:" == location.protocol, 
                 w = "<form method='post' action='http" + (p ? "s" : "") + "://localhost:3000/logger/" + z + "/err'>", 
                 m = [], 
                 r = "before", 
                 s = document.getElementsByTagName("script")[0], 
                 g = Array.prototype.slice, 
                 t = navigator.userAgent, 
                 k, 
                 n = function (a, e) {
                   for (var c in a) a.hasOwnProperty(c) && e(c, a[c])
                 }, 
                 u = function (a) {
                   k && clearTimeout(k);
                   a.w = r;
                   try {
                     if (a.x = {}, n(_data.meta || {}, function (c, b) {
                        a.x[c] = b
                     }), t.indexOf("MSIE") ^ -1) {
                       for (var e, 
                                c = a.callee, 
                                b = /function\s*([\w\-$]+)?\s*\(/i,
                                d = [], 
                                h; 
                                c && c.arguments && 10 > d.length;) h = b.test(c.toString()) ? RegExp.$1 || "{anonymous}" : "{anonymous}", d.push(h + "(" + (p ? "" : j(g.call(c.arguments || []))) + ")"), c = c.caller;
                        if (e = 1 < d.length ? d.join("\n") : "") a.s = e
                      }
                    } catch (y) {}
                    m.push(a);
                    k = setTimeout(x, 200)
                  }, 
                  x = function () {
                    for (var a, e = 0, c = {}, b = function (a, b) {
                        c[a + e] = b
                  }, 
                  d = function (a) {
                      var b = 0;
                      n(a.x, function (d, f) {
                          if (/string|number|boolean/.test(typeof f)) {
                              var g = "meta" + e;
                              c[g + "name" + b] = d;
                              c[g + "value" + b] = a.x[d];
                              b++
                          }
                      })
                    }, 
                    h = function (a, b) {
                        return "Error loading script" == a && /Firefox/.test(t) ||
                            /originalCreateNotification/.test(a) || /atomicFindClose/.test(a) || /jid1\-ejhbjdxm9zr4tq/.test(b) || "miscellaneous_bindings" == b
                    }, 
                    j = function (c, d, e) {
                        n({
                            message: c,
                            url: d,
                            line: e,
                            page: location.href,
                            when: a.w,
                            api_key: z
                        }, b)
                    }; 
                    a = m.shift();) {
                      var f = a.m || a[0],
                          g = a.u || a[1],
                          k = a.l || a[2];
                          f && "string" == typeof f && g && k && !h(f, g) ? (j(f, g, k), a.s && b("stack", a.s), d(a), e++) : a instanceof Error && !h(a.message, a.fileName) && (f = m.shift(), f[0].indexOf(a.message) ^ -1 ? (j.apply(f, f), b("stack", a.stacktrace || a.stack), b("method", "e"), d(a), e++) : m.unshift(f))
                          console.log(a);
                          console.log(f)
                    }
                try {
                    var l = document.createElement("iframe");
                    l.src = "javascript:";
                    l.style.display = "none";
                    s.parentNode.insertBefore(l, s);
                    var q = w;
                    n(c, function (a, b) {
                      q += "<textarea name=" + a + ">" + ("" + b).replace(/</g, "&lt;") + "</textarea>"
                    });
                    d = l;
                    h = q + "</form><script>onload=function(){setTimeout(function(){document.forms[0].submit()},10);}\x3c/script>";
                    d = d.contentWindow || d.contentDocument;
                    d = d.document || d;
                    d.open();
                    d.write(h);
                    d.close();
                    setTimeout(function () {
                        l.parentNode.removeChild(l)
                    }, 1E4)
                } catch (p) {}
            }, j = function (a) {
                for (var e = [], c = 0; c < a.length; ++c) {
                    var b =
                        a[c];
                    void 0 === b || null === b ? e[c] = "" + b : b.constructor && (b.constructor == Array ? e[c] = 3 > b.length ? "[" + j(b) + "]" : "[" + j(g.call(b, 0, 1)) + "..." + j(g.call(b, -1)) + "]" : b.constructor == Object ? e[c] = "#object" : b.constructor == Function ? e[c] = "#function" : b.constructor == String ? e[c] = '"' + b + '"' : b.constructor == Number && (e[c] = b))
                }
                return e.join()
            }, v; v = _data.shift();) u(v);
        r = "after";
        _data = {
            push: u,
            meta: _data.meta
        }
    }
})();