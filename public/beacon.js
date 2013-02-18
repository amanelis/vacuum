(function () {
    if (window._errs && _errs.shift) {
        for (var m = location.protocol, u = "<form method='post' action='http://localhost:3000/logger/" + _errs.shift() + "/err'>", n = [], p = "before", q = document.getElementsByTagName("script")[0], h = Array.prototype.slice, r = navigator.userAgent, v = ["string", "number", "boolean"], f, w = function (b, d) {
            d = ("" + d).replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&quot;");
            return "<input name='" + b + "' value='" + d + "' />"
        }, l = function (b, d) {
            for (var c in b) b.hasOwnProperty(c) && d(c, b[c])
        }, s = function (b) {
            f && clearTimeout(f);
            b._w = p;
            try {
                if (_errs.meta && "object" == typeof _errs.meta && (b._meta = {}, l(_errs.meta, function (a, c) {
                    b._meta[a] = c
                })), -1 != r.indexOf("MSIE")) {
                    var d;
                    for (var c = b.callee, a = /function\s*([\w\-$]+)?\s*\(/i, e = [], j, k; c && c.arguments && 10 > e.length;) j = a.test(c.toString()) ? RegExp.$1 || "{anonymous}" : "{anonymous}", k = h.call(c.arguments || []), e.push(j + "(" + g(k) + ")"), c = c.caller;
                    d = 1 < e.length ? e.join("\n") : void 0;
                    d && (b._s = d)
                }
            } catch (z) {}
            n.push(b);
            f = setTimeout(x, 200)
        }, x = function () {
            for (var b,
            d = 0, c = {}, a = function (a, b) {
                c[a + d] = b
            }; b = n.shift();) {
                var e = b.m || b[0],
                    j = b.u || b[1],
                    k = b.l || b[2];
                if (e && "string" == typeof e && j && k) if ("Error loading script" == e && /Firefox/.test(r) || /originalCreateNotification/.test(e) || /jid1\-ejhbjdxm9zr4tq/.test(j)) d--;
                else {
                    if (l({
                        message: e,
                        url: j,
                        line: k,
                        page: location.href,
                        when: b._w
                    }, a), b._s && a("stack", b._s), b._meta) {
                        var g = 0;
                        l(b._meta, function (a, e) {
                            if (-1 != v.indexOf(typeof e)) {
                                var f = "meta" + d;
                                c[f + "name" + g] = a;
                                c[f + "value" + g] = b._meta[a];
                                g++
                            }
                        })
                    }
                } else d--;
                d++
            }
            try {
                var i = document.createElement("iframe");
                i.src = "javascript:false;";
                i.style.display = "none";
                q.parentNode.insertBefore(i, q);
                var h, f = [u];
                l(c, function (a, b) {
                    f.push(w(a, b))
                });
                f.push("</form><script>window.onload=function(){setTimeout(function(){document.getElementsByTagName('form')[0].submit()},10);}<\/script>");
                h = f.join("");
                a = i;
                a = a.contentWindow || a.contentDocument;
                a.document && (a = a.document);
                a.open();
                a.write(h);
                a.close();
                setTimeout(function () {
                    i.parentNode.removeChild(i)
                }, 1E4)
            } catch (m) {}
        }, g = function (b) {
            if ("https:" == m) return "";
            for (var d = [], c = 0; c < b.length; ++c) {
                var a = b[c];
                void 0 === a ? d[c] = "undefined" : null === a ? d[c] = "null" : a.constructor && (a.constructor == Array ? d[c] = 3 > a.length ? "[" + g(a) + "]" : "[" + g(h.call(a, 0, 1)) + "..." + g(h.call(a, -1)) + "]" : a.constructor == Object ? d[c] = "#object" : a.constructor == Function ? d[c] = "#function" : a.constructor == String ? d[c] = '"' + a + '"' : a.constructor == Number && (d[c] = a))
            }
            return d.join(",")
        }, t, y = _errs.meta; t = _errs.shift();) s(t);
        p = "after";
        _errs = {
            push: s,
            meta: y
        }
    }
})();