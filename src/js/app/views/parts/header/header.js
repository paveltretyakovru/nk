define(function(require) {
  'use strict';
  var ForgotPasswordComponent, Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/header/header.html');
  ForgotPasswordComponent = require('components/animatedmodal/forgotpassword/forgotpassword');
  require('gsap');
  return Marionette.LayoutView.extend({
    debugAnimation: false,
    debug: false,
    template: Template,
    tagName: 'header',
    regions: {
      regionForgotPassword: '.js-forgot-from-header'
    },
    ui: {
      'linkMenu': '.js-link-menu',
      'link_loginFromHeader': '.js-login-from-header',
      'link_registrateFromHeader': '.js-registrate-from-header',
      'link_forgotPassword': '.js-forgot-from-header'
    },
    events: {
      'click @ui.linkMenu': 'showMenu',
      'click @ui.link_loginFromHeader': 'showLoginFromHeader',
      'click @ui.link_registrateFromHeader': 'showRegistrateFromHeader',
      'click @ui.link_forgotPassword': 'showForgotPasswordFromHeader'
    },
    initialize: function() {
      return this.on('render', this.afterRender, this);
    },
    onRender: function() {
      this.forgotPassword = new ForgotPasswordComponent();
      window.tComp = this.forgotPassword;
      return this.regionForgotPassword.show(this.forgotPassword);
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
    },
    showForgotPasswordFromHeader: function(event) {
      console.log('SHow forgot from header function');
      return event.preventDefault();
    }
  });
});
