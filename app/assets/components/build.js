;(function(){


/**
 * hasOwnProperty.
 */

var has = Object.prototype.hasOwnProperty;

/**
 * Require the given path.
 *
 * @param {String} path
 * @return {Object} exports
 * @api public
 */

function require(path, parent, orig) {
  var resolved = require.resolve(path);

  // lookup failed
  if (null == resolved) {
    orig = orig || path;
    parent = parent || 'root';
    var err = new Error('Failed to require "' + orig + '" from "' + parent + '"');
    err.path = orig;
    err.parent = parent;
    err.require = true;
    throw err;
  }

  var module = require.modules[resolved];

  // perform real require()
  // by invoking the module's
  // registered function
  if (!module.exports) {
    module.exports = {};
    module.client = module.component = true;
    module.call(this, module.exports, require.relative(resolved), module);
  }

  return module.exports;
}

/**
 * Registered modules.
 */

require.modules = {};

/**
 * Registered aliases.
 */

require.aliases = {};

/**
 * Resolve `path`.
 *
 * Lookup:
 *
 *   - PATH/index.js
 *   - PATH.js
 *   - PATH
 *
 * @param {String} path
 * @return {String} path or null
 * @api private
 */

require.resolve = function(path) {
  if (path.charAt(0) === '/') path = path.slice(1);
  var index = path + '/index.js';

  var paths = [
    path,
    path + '.js',
    path + '.json',
    path + '/index.js',
    path + '/index.json'
  ];

  for (var i = 0; i < paths.length; i++) {
    var path = paths[i];
    if (has.call(require.modules, path)) return path;
  }

  if (has.call(require.aliases, index)) {
    return require.aliases[index];
  }
};

/**
 * Normalize `path` relative to the current path.
 *
 * @param {String} curr
 * @param {String} path
 * @return {String}
 * @api private
 */

require.normalize = function(curr, path) {
  var segs = [];

  if ('.' != path.charAt(0)) return path;

  curr = curr.split('/');
  path = path.split('/');

  for (var i = 0; i < path.length; ++i) {
    if ('..' == path[i]) {
      curr.pop();
    } else if ('.' != path[i] && '' != path[i]) {
      segs.push(path[i]);
    }
  }

  return curr.concat(segs).join('/');
};

/**
 * Register module at `path` with callback `definition`.
 *
 * @param {String} path
 * @param {Function} definition
 * @api private
 */

require.register = function(path, definition) {
  require.modules[path] = definition;
};

/**
 * Alias a module definition.
 *
 * @param {String} from
 * @param {String} to
 * @api private
 */

require.alias = function(from, to) {
  if (!has.call(require.modules, from)) {
    throw new Error('Failed to alias "' + from + '", it does not exist');
  }
  require.aliases[to] = from;
};

/**
 * Return a require function relative to the `parent` path.
 *
 * @param {String} parent
 * @return {Function}
 * @api private
 */

require.relative = function(parent) {
  var p = require.normalize(parent, '..');

  /**
   * lastIndexOf helper.
   */

  function lastIndexOf(arr, obj) {
    var i = arr.length;
    while (i--) {
      if (arr[i] === obj) return i;
    }
    return -1;
  }

  /**
   * The relative require() itself.
   */

  function localRequire(path) {
    var resolved = localRequire.resolve(path);
    return require(resolved, parent, path);
  }

  /**
   * Resolve relative to the parent.
   */

  localRequire.resolve = function(path) {
    var c = path.charAt(0);
    if ('/' == c) return path.slice(1);
    if ('.' == c) return require.normalize(p, path);

    // resolve deps by returning
    // the dep in the nearest "deps"
    // directory
    var segs = parent.split('/');
    var i = lastIndexOf(segs, 'deps') + 1;
    if (!i) i = 0;
    path = segs.slice(0, i + 1).join('/') + '/deps/' + path;
    return path;
  };

  /**
   * Check if module is defined at `path`.
   */

  localRequire.exists = function(path) {
    return has.call(require.modules, localRequire.resolve(path));
  };

  return localRequire;
};

require.register("timoxley-throttle/index.js", function(exports, require, module){
/**
 * Module exports
 */
module.exports = throttle
module.exports.debounce = debounce

/**
 * Returns a function, that, when invoked, will only be triggered at most once during a given window of time.
 *
 * @param {Number} func target function to invoke.
 * @param {Number} wait milliseconds to wait before allowing another invokation.
 * @return {Function} Throttled function.
 * @api public
 */
function throttle(wait, func) {
  var context, args, timeout, throttling, more, result;
  var whenDone = debounce(wait, function(){ more = throttling = false; });
  return function() {
    context = this; args = arguments;
    var later = function() {
      timeout = null;
      if (more) {
        result = func.apply(context, args);
      }
      whenDone();
    };
    if (!timeout) timeout = setTimeout(later, wait);
    if (throttling) {
      more = true;
    } else {
      throttling = true;
      result = func.apply(context, args);
    }
    whenDone();
    return result;
  };
};

/**
 * Returns a function, that, as long as it continues to be invoked, will not be triggered. The function will be called after it stops being called for `wait` milliseconds.
 *
 * @param {Number} func target function to invoke.
 * @param {Number} wait milliseconds to wait before allowing another invokation.
 * @param {Boolean} immediate trigger the function on the leading edge, instead of the trailing.
 * @return {Function} Throttled function.
 * @api public
 */
function debounce(wait, func, immediate) {
  var timeout, result;
  return function() {
    var context = this, args = arguments;
    var later = function() {
      timeout = null;
      if (!immediate) result = func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) result = func.apply(context, args);
    return result;
  };
};

});
require.register("avetisk-defaults/index.js", function(exports, require, module){
/**
 * Expose `defaults`.
 */
module.exports = defaults;

/**
 * Merge default values.
 *
 * @param {Object} dest
 * @param {Object} defaults
 * @return {Object}
 * @api public
 */
function defaults (dest, defaults) {
  for (var prop in defaults) {
    if (! (prop in dest)) {
      dest[prop] = defaults[prop];
    }
  }

  return dest;
};

});
require.register("jasonkuhrt-scroll-over/index.js", function(exports, require, module){
(function(){
  var defaults, throttle, ScrollOver, slice$ = [].slice;
  defaults = require('defaults');
  throttle = require('throttle');
  module.exports = scrollOverFactory;
  function scrollOverFactory(node){
    var rest;
    rest = slice$.call(arguments, 1);
    if (rest.length === 1) {
      rest.unshift({});
    }
    return (function(func, args, ctor) {
      ctor.prototype = func.prototype;
      var child = new ctor, result = func.apply(child, args), t;
      return (t = typeof result)  == "object" || t == "function" ? result || child : child;
  })(ScrollOver, [node].concat(slice$.call(rest)), function(){});
  }
  ScrollOver = (function(){
    ScrollOver.displayName = 'ScrollOver';
    var prototype = ScrollOver.prototype, constructor = ScrollOver;
    function ScrollOver(node, options, callback){
      this.node = node;
      this.callback = callback;
      this.refresh = bind$(this, 'refresh', prototype);
      this.options = defaults(options, {
        windowPoint: 'start',
        orientation: 'vertical',
        throttleMs: 10
      });
      this.lastCrossDirection = null;
      window.addEventListener('scroll', throttle(this.options.throttleMs, this.refresh));
      if (this.options.windowPoint !== 'start') {
        window.addEventListener('resize', throttle(this.options.throttleMs, this.refresh));
      }
      this.refresh();
    }
    prototype.refresh = function(){
      return this.cross(this.checkCross(this.calcNodeOffset(this.node, this.options.windowPoint, this.options.orientation)));
    };
    prototype.cross = function(inDirection){
      if (inDirection) {
        this.lastCrossDirection = inDirection;
        return this.callback.call(null, inDirection, this.node);
      }
    };
    prototype.checkCross = function(distanceFromWindow){
      if (distanceFromWindow < 0 && this.lastCrossDirection !== 'inward') {
        return 'inward';
      }
      if (distanceFromWindow > 0 && this.lastCrossDirection !== 'outward') {
        return 'outward';
      }
      return false;
    };
    prototype.calcNodeOffset = function(node, windowPoint, orientation){
      switch (windowPoint) {
      case 'start':
        return nodeOffset();
      case 'middle':
        return nodeOffset() - windowSize() / 2;
      case 'end':
        return nodeOffset() - windowSize();
      }
      function nodeOffset(){
        return node.getBoundingClientRect()[orientation === 'vertical' ? 'top' : 'left'];
      }
      function windowSize(){
        return window[orientation === 'vertical' ? 'innerHeight' : 'innerWidth'];
      }
      return windowSize;
    };
    return ScrollOver;
  }());
  function bind$(obj, key, target){
    return function(){ return (target || obj)[key].apply(obj, arguments) };
  }
}).call(this);

});
require.register("yields-slug/index.js", function(exports, require, module){

/**
 * Generate a slug from the given `str`.
 *
 * example:
 *
 *        generate('foo bar');
 *        // > foo-bar
 *
 * @param {String} str
 * @param {Object} options
 * @config {String|RegExp} [replace] characters to replace, defaulted to `/[^a-z0-9]/g`
 * @config {String} [separator] separator to insert, defaulted to `-`
 * @return {String}
 */

module.exports = function (str, options) {
  options || (options = {});
  return str.toLowerCase()
    .replace(options.replace || /[^a-z0-9]/g, ' ')
    .replace(/^ +| +$/g, '')
    .replace(/ +/g, options.separator || '-')
};

});
require.register("angular-escape/index.js", function(exports, require, module){



module.exports = 'escape';

angular.module('escape', [])

.directive('escape', [function() { return {

  priority: 1000,
  terminal: true,
  compile: function(telm) {
    telm.html(jQuery('<div/>').text(telm.html()).html().replace(/=""|=''/,''));
  }

};}])



.directive('codeblock', [function() { return {

    restrict: 'E',
    priority: 1000,
    terminal: true,
    compile: function(telm) {
      telm.replaceWith(jQuery('<pre/>').text(telm.html()).wrap('<div/>').parent().html().replace(/=""|=''/,''));
    }


};}]);


});
require.register("components/index.js", function(exports, require, module){



module.exports = function requireForwarder(name) {
  return require(name);
};

});

require.alias("jasonkuhrt-scroll-over/index.js", "components/deps/scroll-over/index.js");
require.alias("timoxley-throttle/index.js", "jasonkuhrt-scroll-over/deps/throttle/index.js");

require.alias("avetisk-defaults/index.js", "jasonkuhrt-scroll-over/deps/defaults/index.js");

require.alias("yields-slug/index.js", "components/deps/slug/index.js");

require.alias("angular-escape/index.js", "components/deps/angular-escape/index.js");

if (typeof exports == "object") {
  module.exports = require("components");
} else if (typeof define == "function" && define.amd) {
  define(function(){ return require("components"); });
} else {
  window["require"] = require("components");
}})();