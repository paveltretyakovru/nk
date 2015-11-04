define(function(require) {
  'use strict';
  var AuthComponent, ForgotPasswordComponent, Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/header/header.html');
  ForgotPasswordComponent = require('components/animatedmodal/forgotpassword/forgotpassword');
  AuthComponent = require('components/animatedmodal/auth/auth');
  require('gsap');
  return Marionette.LayoutView.extend({
    debugAnimation: false,
    debug: false,
    template: Template,
    tagName: 'header',
    regions: {
      regionForgotPassword: '.js-forgot-from-header',
      regionAuth: '.js-auth-animated-modal'
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
      this.forgotPassword = new ForgotPasswordComponent();
      this.authComponent = new AuthComponent();
      window.tComp = this.forgotPassword;
      window.authComponent = this.authComponent;
      this.regionForgotPassword.show(this.forgotPassword);
      return this.regionAuth.show(this.authComponent);
    },
    afterRender: function() {},
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
