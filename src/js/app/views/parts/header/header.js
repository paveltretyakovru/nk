define(function(require) {
  'use strict';
  var Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/header/header.html');
  require('gsap');
  return Marionette.ItemView.extend({
    debugAnimation: false,
    debug: false,
    template: Template,
    tagName: 'header',
    ui: {
      'linkRegistration': '.js-link-registration',
      'linkLogin': '.js-link-login',
      'linkMenu': '.js-link-menu'
    },
    events: {
      'click @ui.linkLogin': 'showLogin',
      'click @ui.linkRegistration': 'showRegistration',
      'click @ui.linkMenu': 'showMenu'
    },
    initialize: function() {
      return this.on('render', this.afterRender, this);
    },
    afterRender: function() {
      var _this;
      _this = this;
      this.scaleBody = document.getElementById('scale-body');
      this.scaleClass = 'scale-element';
      this.scaleAnimation = new TimelineMax({
        paused: true,
        onComplete: function() {
          return _this.authVisible = true;
        },
        onReverseComplete: function() {
          return _this.authVisible = false;
        }
      }).to(this.scaleBody, 0.5, {
        className: '+=' + this.scaleClass
      });
      return this.scaleBody.addEventListener('click', (function(_this) {
        return function() {
          if (_this.authVisible) {
            app.regionLogin.currentView.trigger('hideLogin');
            return _this.scaleAnimation.reverse();
          }
        };
      })(this));
    },
    showLogin: function(event) {
      if (this.debug) {
        console.log('views/parts/header/header.showLogin : debug');
      }
      app.regionLogin.currentView.trigger('showLogin');
      this.scaleAnimation.play();
      return event.preventDefault();
    },
    showRegistration: function(event) {
      app.regionLogin.currentView.trigger('showLogin');
      this.scaleAnimation.play();
      return event.preventDefault();
    },
    showMenu: function(event) {
      if (this.debug) {
        console.log('Show menu');
      }
      app.regionMenu.currentView.trigger('showMenu');
      return event.preventDefault();
    }
  });
});
