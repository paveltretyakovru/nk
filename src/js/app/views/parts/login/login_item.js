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
      			 * ------------- Анимации выводит блок авторизации -------------
       */
      this.dropSectionFromSide = new TimelineMax({
        paused: true
      }).addLabel('startAnimation').set(this.registerSide, {
        rotationX: -180
      }).to(this.sectionElement, .3, {
        right: '0%',
        alpha: 1
      }, 0).addLabel('dropSection').to(this.registerSide, .5, {
        rotationX: 0
      }, 1).to(this.loginSide, .5, {
        rotationX: 180
      }, 1).addLabel('revertRegistr');
      window.test = this.dropSectionFromSide;
      return this.scaleElement.addEventListener('click', (function(_this) {
        return function() {
          if (_this.sectionDropped()) {
            return _this.dropSectionFromSide.tweenTo(0);
          }
        };
      })(this));
    },
    sectionDropped: function() {
      return !this.dropSectionFromSide.isActive() && this.dropSectionFromSide.progress();
    },
    showRegistrateFromLogin: function(event) {
      this.dropSectionFromSide.tweenTo('revertRegistr');
      return event.preventDefault();
    },
    showRegistrateFromHeader: function(event) {
      return this.dropSectionFromSide.tweenFromTo('startAnimation', 'revertRegistr');
    },
    showLoginFromRegistrate: function(event) {
      this.dropSectionFromSide.tweenTo('dropSection');
      return event.preventDefault();
    },
    showLoginFromHeader: function(event) {
      return this.dropSectionFromSide.tweenFromTo('startAnimation', 'dropSection');
    }
  });
  return View;
});
