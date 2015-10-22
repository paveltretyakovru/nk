define(function(requrie) {
  'use strict';
  var Animations;
  require('gsap');
  Animations = {
    tweens: {},
    elements: {},
    animations: {},
    initialize: function() {
      this.elements.main = document.getElementById('scale-body');
      this.elements.loader = document.getElementById('loader');
      this.elements.header = document.getElementById('region-header');
      this.elements.content = document.getElementById('region-content');
      TweenMax.set([this.elements.main, this.elements.header, this.elements.content], {
        autoAlpha: 0
      });
      this.animations.hideMain = (function(_this) {
        return function(callback) {
          _this.tweens.hideMain = new TimelineLite({
            onComplete: function() {
              return _this.animations.showLoader(function() {
                return _this.animations.hideLoader(function() {
                  if (callback != null) {
                    return callback();
                  }
                });
              });
            },
            paused: true
          });
          _this.tweens.hideMain.set([_this.elements.main, _this.elements.header, _this.elements.content], {
            autoAlpha: 1
          }).to(_this.elements.main, 2, {
            autoAlpha: 0,
            display: 'none'
          }, 0).to(_this.elements.content, 1, {
            autoAlpha: 0
          }, 1).to(_this.elements.header, .5, {
            autoAlpha: 0
          }, 1.5);
          return _this.tweens.hideMain.play();
        };
      })(this);
      this.animations.showMain = (function(_this) {
        return function(callback) {
          if (_this.tweens.hideMain != null) {
            return _this.tweens.hideMain.reverse();
          } else {
            _this.tweens.showMain = new TimelineLite({
              onStart: function() {
                if (callback != null) {
                  return callback();
                }
              },
              paused: true
            });
            _this.tweens.showMain.set([_this.elements.main, _this.elements.header, _this.elements.content], {
              autoAlpha: 0
            });
            _this.tweens.showMain.to(_this.elements.main, 2, {
              autoAlpha: 1
            }, 0);
            _this.tweens.showMain.to(_this.elements.header, 1, {
              autoAlpha: 1
            }, 1);
            _this.tweens.showMain.to(_this.elements.content, .5, {
              autoAlpha: 1
            }, 1.5);
            return _this.tweens.showMain.play();
          }
        };
      })(this);
      this.animations.showLoader = (function(_this) {
        return function(callback) {
          _this.tweens.showLoader = new TimelineLite({
            paused: true,
            onComplete: function() {
              if (callback != null) {
                return callback();
              }
            }
          });
          _this.tweens.showLoader.to(_this.elements.loader, 1, {
            opacity: 1
          }, 0);
          return _this.tweens.showLoader.play();
        };
      })(this);
      return this.animations.hideLoader = (function(_this) {
        return function(callback) {
          _this.tweens.hideLoader = new TimelineLite({
            paused: true,
            onComplete: function() {
              if (callback != null) {
                return callback();
              }
            }
          });
          _this.tweens.hideLoader.to(_this.elements.loader, .5, {
            opacity: 0
          }, 0);
          return _this.tweens.hideLoader.play();
        };
      })(this);
    }
  };
  Animations.initialize();
  return Animations;
});
