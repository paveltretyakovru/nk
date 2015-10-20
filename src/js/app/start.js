require(['app/app', 'pace'], function(app, pace) {
  'use strict';
  var loader;
  window.addClass = function(el, className) {
    if (el.classList != null) {
      return el.classList.add(className);
    } else {
      return el.classList += ' ' + className;
    }
  };
  window.removeClass = function(el, className) {
    var reg;
    if (el.classList) {
      return el.classList.remove(className);
    } else {
      reg = new RegExp('(^|\\b)' + className.split(' ').join('|') + '(\\b|$)', 'gi');
      return el.className = el.className.replace(reg, ' ');
    }
  };
  window.addEvent = function(el, eventName, callback) {
    if (el.addEventListener) {
      return el.addEventListener(eventName, callback, false);
    } else if (el.attachEvent) {
      console.log('Attach event');
      return el.attachEvent('on' + eventName, callback);
    }
  };
  window.app = app || false;
  loader = document.getElementById('loader');
  addEvent(loader, 'webkitAnimationEnd', function() {
    if (loader.style.display !== 'none') {
      loader.style.display = 'none';
    }
    return app.start();
  });
  addEvent(loader, 'animationend', function() {
    if (loader.style.display !== 'none') {
      loader.style.display = 'none';
    }
    return app.start();
  });
  pace.on('start', function() {
    if (app.debug) {
      return console.log('Pace start');
    }
  });
  pace.on('done', function() {
    if (app.debug) {
      console.log('Pace done');
    }
    addClass(loader, 'fadeout');
    return removeClass(loader, 'fadein-loader');
  });
  return pace.start({
    document: false
  });
});
