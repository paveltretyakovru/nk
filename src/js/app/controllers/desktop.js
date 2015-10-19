define(function(require) {
  'use strict';
  var HeaderView, LoginView, Marionette, MenuView, Pages;
  Marionette = require('marionette');
  HeaderView = require('views/parts/header/header');
  LoginView = require('views/parts/login/login_item');
  MenuView = require('views/parts/menu/menu_itemview');
  Pages = {
    Home: require('views/pages/home/home')
  };
  return Marionette.Controller.extend({
    debug: true,
    initialize: function() {
      if (this.debug) {
        return console.log('controllers/desktop : initializin function');
      }
    },
    run: function(pageName, pageParameters) {
      var Header, Login, Menu, Page, args;
      if (this.debug) {
        console.log('controllers/desktop.run : route->' + pageName);
      }
      args = Array.prototype.slice.call(arguments);
      Page = new Pages[args.shift()](args);
      Header = new HeaderView();
      Login = new LoginView();
      Menu = new MenuView();
      app.regionContent.show(Page);
      app.regionHeader.show(Header);
      app.regionLogin.show(Login);
      return app.regionMenu.show(Menu);
    },
    Home: function() {
      return this.run('Home');
    }
  });
});
