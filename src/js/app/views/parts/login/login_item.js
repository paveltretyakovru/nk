define(function(require) {
  'use strict';
  var Marionette, Template, View;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/login/login.html');
  require('gsap');
  require('syphon');
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
      'click @ui.link_loginFromRegistrate': 'showLoginFromRegistrate',
      'submit #login_form': 'doLogin',
      'submit #register_form': 'doRegister'
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
      }).add('startAnimation').set(this.registerSide, {
        rotationX: -180
      }).to(this.scaleElement, .3, {
        className: '+=' + this.scaleClass + ' background-color-overlay'
      }, 0).to(this.sectionElement, .3, {
        right: '0%',
        alpha: 1
      }, 0).addLabel('backToLogin').addLabel('dropSection').to(this.registerSide, .5, {
        rotationX: 0
      }, .3).to(this.loginSide, .5, {
        rotationX: 180
      }, .3).addLabel('revertRegistr');

      /* ___________ Анимация выводит формы регистрации ___________ */
      this.dropRegistrateFromHeader = new TimelineMax({
        paused: true
      }).add('startAnimation').set(this.registerSide, {
        rotationX: -180
      }).set(this.registerSide, {
        rotationX: 0
      }, 'setRevertRegistr').set(this.loginSide, {
        rotationX: 180
      }, 'setRevertRegistr').add(app.tweens.scaleBody.play(), 'startAnimation').to(this.sectionElement, .3, {
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
      this.controlReversedAnimations((function(_this) {
        return function() {
          return _this.dropSectionFromSide.tweenFromTo('revertRegistr', 'dropSection');
        };
      })(this));
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
    },
    doLogin: function(event) {
      var data;
      event.preventDefault();
      data = Backbone.Syphon.serialize(this);
      $.post('http://localhost:3000' + '/api/v1/auth/sessions.json', data, (function(_this) {
        return function(result) {
          return console.log("result login: ", result);
        };
      })(this));
      return console.log('do login', data);
    },
    doRegister: function(event) {
      var data;
      event.preventDefault();
      data = Backbone.Syphon.serialize(this);
      $.post('http://localhost:3000' + '/api/v1/auth/registrations.json', data, (function(_this) {
        return function(result) {
          return console.log("result register: ", result);
        };
      })(this));
      return console.log('do register', data);
    }
  });
  return View;
});
