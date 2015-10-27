define(function(require) {
  'use strict';
  var Marionette, Template, View;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/login/login.html');
  require('gsap');
  View = Marionette.ItemView.extend({
    debugAnimation: true,
    debug: true,
    template: Template,
    ui: {
      'link_registrateFromLogin': '.js-registrate-from-login',
      'link_loginFromRegistrate': '.js-login-from-registrate'
    },
    events: {
      'click @ui.link_registrateFromLogin': 'showRegistrateFromLogin',
      'click @ui.link_loginFromRegistrate': 'showLoginFromRegistrate'
    },
    initialize: function() {
      this.on('showLoginFromHeader', this.showLoginFromHeader, this);
      this.on('showRegistrateFromHeader', this.showRegistrateFromHeader, this);
      this.on('hideLogin', this.hideLogin, this);
      return this.on('render', this.afterRender, this);
    },
    afterRender: function() {
      var pause;
      this.sectionElement = this.el.querySelectorAll('.autn-section');
      this.registerSide = this.el.querySelector('.registr-side');
      this.loginSide = this.el.querySelector('.login-side');
      this.scaleElement = document.getElementById('scale-body');
      this.scaleClass = 'scale-element';
      this.authVisible = false;
      pause = (function(_this) {
        return function() {
          return _this.dropSectionFromSide.pause();
        };
      })(this);
      CSSPlugin.defaultTransformPerspective = 0;

      /**
      			 * ------------- Анимации выводит блок аутентификации -------------
       */
      this.dropSectionFromSide = new TimelineMax({
        paused: true
      }).addLabel('startAnimation').set(this.registerSide, {
        rotationX: -180
      }).to(this.sectionElement, .3, {
        right: '0%',
        alpha: 1
      }, 0).addLabel('backToLogin').addLabel('dropSection').to(this.registerSide, .5, {
        rotationX: 0
      }, .3).to(this.loginSide, .5, {
        rotationX: 180
      }, .3).addLabel('revertRegistr');
      this.dropRegistrateFromHeader = new TimelineMax({
        paused: true
      }).addLabel('startAnimation').set(this.registerSide, {
        rotationX: -180
      }).set(this.registerSide, {
        rotationX: 0
      }, 'setRevertRegistr').set(this.loginSide, {
        rotationX: 180
      }, 'setRevertRegistr').to(this.sectionElement, .3, {
        right: '0%',
        alpha: 1
      }, 0).addLabel('dropSection');
      window.test = this.dropSectionFromSide;
      return this.scaleElement.addEventListener('click', (function(_this) {
        return function() {
          return _this.controlReversedAnimations(function() {
            return console.log('scaleElement');
          });
        };
      })(this));
    },
    controlReversedAnimations: function(callback) {
      var control;
      control = false;
      if (this.sectionDropped()) {
        console.log('sectionDropped');
        if (callback != null) {
          this.dropSectionFromSide.eventCallback('onReverseComplete', function() {
            return callback();
          });
        }
        return this.dropSectionFromSide.reverse();
        control = true;
      }
      if (this.registrateFromHeader()) {
        console.log('registrateFromHeader');
        if (callback != null) {
          this.dropRegistrateFromHeader.eventCallback('onReverseComplete', function() {
            return callback();
          });
        }
        return this.dropRegistrateFromHeader.reverse();
        control = true;
      }
      if (!control && (callback != null)) {
        console.log('not Control and callback?');
        return callback();
      }
    },
    sectionDropped: function() {
      return !this.dropSectionFromSide.isActive() && this.dropSectionFromSide.progress();
    },
    registrateFromHeader: function() {
      return !this.dropRegistrateFromHeader.isActive() && this.dropRegistrateFromHeader.progress();
    },
    showRegistrateFromLogin: function(event) {
      this.dropSectionFromSide.tweenTo('revertRegistr');
      return event.preventDefault();
    },
    showLoginFromRegistrate: function(event) {
      this.dropSectionFromSide.tweenFromTo('revertRegistr', 'dropSection');
      return event.preventDefault();
    },

    /* From Header */
    showRegistrateFromHeader: function(event) {
      return this.controlReversedAnimations((function(_this) {
        return function() {
          return _this.dropRegistrateFromHeader.tweenFromTo('startAnimation', 'dropSection');
        };
      })(this));
    },
    showLoginFromHeader: function(event) {
      return this.controlReversedAnimations((function(_this) {
        return function() {
          return _this.dropSectionFromSide.tweenFromTo('startAnimation', 'backToLogin');
        };
      })(this));
    }
  });
  return View;
});
