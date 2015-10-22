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
      'linkMenu': '.js-link-menu',
      'link_loginFromHeader': '.js-login-from-header',
      'link_registrateFromHeader': '.js-registrate-from-header'
    },
    events: {
      'click @ui.linkMenu': 'showMenu',
      'click @ui.link_loginFromHeader': 'showLoginFromHeader',
      'click @ui.link_registrateFromHeader': 'showRegistrateFromHeader'
    },
    initialize: function() {
      return this.on('render', this.afterRender, this);
    },
    afterRender: function() {},
    showLoginFromHeader: function(event) {
      app.regionLogin.currentView.trigger('showLoginFromHeader');
      return event.preventDefault();
    },
    showRegistrateFromHeader: function(event) {
      app.regionLogin.currentView.trigger('showRegistrateFromHeader');
      return event.preventDefault();
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
