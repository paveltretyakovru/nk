define(function(requrie) {
  'use strict';
  var Animations;
  require('gsap');
  Animations = {
    timelines: {},
    animations: {},
    elements: {},
    initialize: function() {
      this.elements.main = document.getElementById('scale-body');
      this.elements.loader = document.getElementById('loader');
      this.animations.hideMain = (function(_this) {
        return function(callback) {
          _this.timelines.hideMain = new TimelineMax({
            onComplete: function() {
              return showLoader(function() {
                return hideLoader(function() {
                  if (callback != null) {
                    return callback();
                  }
                });
              });
            },
            paused: true
          });
          _this.timelines.hideMain.set(_this.elements.main, {
            autoAlpha: 1
          }).to(_this.elements.main, .5, {
            autoAlpha: 0,
            display: 'none'
          });
          return _this.timelines.hideMain.play();
        };
      })(this);
      return this.animations.showMain = (function(_this) {
        return function(callback) {
          if (_this.timelines.hideMain != null) {
            return _this.timelines.hideMain.reverse();
          } else {
            _this.timelines.showMain = new TimelineMax({
              onStart: function() {
                if (callback != null) {
                  return callback();
                }
              },
              paused: true
            });
            _this.timelines.showMain.to(_this.elements.main, 1, {
              autoAlpha: 1
            });
            return _this.timelines.showMain.play();
          }
        };
      })(this);
    }
  };
  Animations.initialize();
  return Animations;
});
