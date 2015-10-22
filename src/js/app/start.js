require(['app/app', 'pace'], function(app, pace) {
  'use strict';
  var loader, main;
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
  window.showLoader = function(callback) {
    var animate;
    animate = new TimelineMax({
      paused: true,
      onComplete: function() {
        if (callback != null) {
          return callback();
        }
      }
    });
    animate.to(loader, 1, {
      opacity: 1
    }, 0);
    return animate.play();
  };
  window.hideLoader = function(callback) {
    var animate;
    animate = new TimelineMax({
      paused: true,
      onComplete: function() {
        if (callback != null) {
          return callback();
        }
      }
    });
    animate.to(loader, .5, {
      opacity: 0
    }, 0);
    return animate.play();
  };
  window.app = app || false;
  loader = document.getElementById('loader');
  main = document.getElementById('scale-body');
  showLoader();
  pace.on('done', function() {
    return hideLoader(function() {
      return app.start();
    });
  });
  return pace.start({
    document: false
  });
});
