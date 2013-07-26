var CanvizUtils = function () {
}

CanvizUtils.escapeHtml = function (str) {
    return jQuery('<div />').text(str).html();
}

CanvizUtils.writeAttribute = function (e, attr, val) {
    jQuery(e).setAttr(attr, val);
}

CanvizUtils.setStyle = function (e, styles) {
    e = jQuery(e);
    for (var property in styles) e.css(property, styles[property]);
}

CanvizUtils.createElement = function (type, attrs) {
    var result = document.createElement(type);

    if (typeof attrs !== 'undefined' && attrs != null) {
        for (var attr in attrs) {
            var attrVal = attrs[attr];
            CanvizUtils.writeAttribute(result, attr, attrVal);
        }
    }

    return result;
}

CanvizUtils.setHtml = function (e, content) {
    jQuery(e).html(content);
}

CanvizUtils.setOpacity = function (e, o) {
    jQuery(e).fadeTo(0, o);
}

CanvizUtils.bind = function (o, f) {
    return function () {
        return f.apply(o, Array.prototype.slice.call(arguments));
    }
}

CanvizUtils.ajaxGet = function (url, params, onComplete) {
    // Force the text type otherwise the request will default to XML and
    // return an undefined result
    jQuery.get(url, params, onComplete, 'text');
}

CanvizUtils.extend = function (destination, source) {
    for (var property in source)
        destination[property] = source[property];
    return destination;
}

// As the original objet model is Prototype's one, the jQuery adapter actually
// contains some bits of Prototype required to support the existing canviz classes.


CanvizUtils.createClass = function () {
    var parent = null, properties = Array.prototype.slice.call(arguments);
    if (typeof properties[0] === 'function')
        parent = properties.shift();

    function klass() {
        this.initialize.apply(this, arguments);
    }

    klass.superclass = parent;

    if (parent) {
        var subclass = function () {
        };
        subclass.prototype = parent.prototype;
        klass.prototype = new subclass;
    }

    for (var i = 0; i < properties.length; i++)
        CanvizUtils.addMethods(klass, properties[i]);

    if (!klass.prototype.initialize)
        klass.prototype.initialize = CanvizUtils.emptyFunction;

    klass.prototype.constructor = klass;

    return klass;
}

// This method is for the adapter's internal use only
CanvizUtils.emptyFunction = function () {
};

// This method is for the adapter's internal use only
CanvizUtils.addMethods = function (that, source) {
    var ancestor = that.superclass && that.superclass.prototype;
    var properties = [];
    for (var property in source) {
        properties.push(property);
    }

    for (var i = 0, length = properties.length; i < length; i++) {
        var property = properties[i], value = source[property];
        if (ancestor && (typeof value === 'function') &&
            CanvizUtils.argumentNames(value)[0] == "$super") {
            var method = value;
            value = (function (m) {
                return function () {
                    return ancestor[m].apply(this, arguments)
                };
            })(property);
            value = CanvizUtils.wrap(value, method);
        }
        that.prototype[property] = value;
    }

    return that;
}

// This method is for the adapter's internal use only
CanvizUtils.argumentNames = function (value) {
    var names = value.toString().match(/^[\s\(]*function[^(]*\(([^\)]*)\)/)[1].replace(/\s+/g, '').split(',');
    return names.length == 1 && !names[0] ? [] : names;
}

// This method is for the adapter's internal use only
CanvizUtils.wrap = function (that, wrapper) {
    return function () {
        return wrapper.apply(this, [CanvizUtils.bind(this, that)].concat(Array.prototype.slice.call(arguments)));
    }
}