define(function(require) {
  'use strict';
  var HeaderView, Marionette, Pages;
  Marionette = require('marionette');
  HeaderView = require('views/parts/header/header');
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
      var Header, Page, args;
      if (this.debug) {
        console.log('controllers/desktop.run : route->' + pageName);
      }
      args = Array.prototype.slice.call(arguments);
      Page = new Pages[args.shift()](args);
      Header = new HeaderView();
      app.regionContent.show(Page);
      return app.regionHeader.show(Header);
    },
    Home: function() {
      return this.run('Home');
    }
  });
});
