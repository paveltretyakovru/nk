define(function(require) {
  'use strict';
  var LoginComponent, Marionette, RegistrationComponent, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/header/header.html');
  LoginComponent = require('components/animatedmodal/auth/login');
  RegistrationComponent = require('components/animatedmodal/auth/registration');
  require('gsap');
  return Marionette.LayoutView.extend({
    debugAnimation: false,
    debug: false,
    template: Template,
    tagName: 'header',
    regions: {
      regionAnimatedmodalRegistration: '.js-animatedmodal-registration',
      regionAnimatedmodalLogin: '.js-animatedmodal-login'
    },
    ui: {
      'linkMenu': '.js-link-menu',
      'link_loginFromHeader': '.js-login-from-header',
      'link_registrateFromHeader': '.js-registrate-from-header'
    },
    initialize: function() {
      return this.on('render', this.afterRender, this);
    },
    onRender: function() {
      console.log('LoginComponent', LoginComponent);
      return this.registrationAnimatedModal = new RegistrationComponent();
    },
    afterRender: function() {},
    onShow: function() {
      return this.regionAnimatedmodalRegistration.show(this.registrationAnimatedModal);
    },
    showLoginFromHeader: function(event) {
      app.regionAnimatedModal.currentView.trigger('showLoginFromHeader');
      return event.preventDefault();
    },
    showRegistrateFromHeader: function(event) {
      app.regionAnimatedModal.currentView.trigger('showRegistrateFromHeader');
      return event.preventDefault();
    },
    showLogin: function(event) {
      if (this.debug) {
        console.log('views/parts/header/header.showLogin : debug');
      }
      app.regionAnimatedModal.currentView.trigger('showLogin');
      this.scaleAnimation.play();
      return event.preventDefault();
    },
    showRegistration: function(event) {
      app.regionAnimatedModal.currentView.trigger('showLogin');
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
