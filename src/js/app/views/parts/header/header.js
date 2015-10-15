define(function(require) {
  'use strict';
  var Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/header/header.html');
  require('gsap');
  return Marionette.ItemView.extend({
    debugAnimation: false,
    debug: true,
    template: Template,
    ui: {
      'linkRegistration': '.js-link-registration',
      'linkLogin': '.js-link-login'
    },
    events: {
      'click @ui.linkLogin': 'showLogin',
      'click @ui.linkRegistration': 'showRegistration'
    },
    initialize: function() {
      return this.on('render', this.afterRender, this);
    },
    afterRender: function() {
      this.scaleBody = document.getElementById('scale-body');
      this.scaleClass = 'scale-element';
      this.scaleAnimation = TweenMax.to(this.scaleBody, 0.5, {
        className: this.scaleClass
      }).paused(true);
      return app.utils.Listener.setClosest({
        id: 'clossetOutLogin',
        title: 'Клик вне логин формы',
        selector: this.scaleBody,
        callbackOnElement: (function(_this) {
          return function() {
            console.log('scaleAnimation before', _this.scaleAnimation.reversed());
            app.regionLogin.currentView.trigger('hideLogin');
            _this.scaleAnimation.reverse();
            return console.log('scaleAnimation after', _this.scaleAnimation.reversed());
          };
        })(this)
      });
    },
    showLogin: function() {
      if (this.debug) {
        console.log('views/parts/header/header.showLogin : debug');
      }
      app.regionLogin.currentView.trigger('showLogin');
      return this.scaleAnimation.play();
    },
    showRegistration: function() {
      app.regionLogin.currentView.trigger('showLogin');
      return this.scaleAnimation.play();
    }
  });
});
