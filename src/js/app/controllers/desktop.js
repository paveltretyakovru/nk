define(function(require) {
  'use strict';
  var HeaderView, LoginView, Marionette, MenuView, Pages;
  Marionette = require('marionette');
  HeaderView = require('views/parts/header/header');
  LoginView = require('views/parts/login/login_item');
  MenuView = require('views/parts/menu/menu_itemview');
  Pages = {
    Home: require('views/pages/home/home'),
    About: require('views/pages/about/about'),
    Community: require('views/pages/community/community_layoutview')
  };
  return Marionette.Controller.extend({
    debug: false,
    hidden: true,
    initialize: function() {
      if (this.debug) {
        console.log('controllers/desktop : initializin function');
      }
      this.Header = new HeaderView();
      this.Login = new LoginView();
      this.Menu = new MenuView();
      app.regionHeader.show(this.Header);
      app.regionLogin.show(this.Login);
      app.regionMenu.show(this.Menu);
      return app.regionContent.on('show', function() {
        return app.animations.showMain();
      });
    },
    run: function(pageName, pageParameters) {
      var Page, args;
      if (this.debug) {
        console.log('controllers/desktop.run : route->' + pageName);
      }
      args = Array.prototype.slice.call(arguments);
      Page = new Pages[args.shift()](args);
      if (this.hidden) {
        app.animations.showMain(function() {
          return app.regionContent.show(Page);
        });
        return this.hidden = false;
      } else {
        return app.animations.hideMain(function() {
          return app.regionContent.show(Page);
        });
      }
    },
    Home: function() {
      return this.run('Home');
    },
    About: function() {
      return this.run('About');
    },
    Community: function() {
      return this.run('Community');
    }
  });
});
