define(function(require) {
  'use strict';
  var Marionette, Pages;
  Marionette = require('marionette');
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
      var args;
      if (this.debug) {
        console.log('controllers/desktop.run : route->' + pageName);
      }
      args = Array.prototype.slice.call(arguments);
      return app.regionContent.show(new Pages[args.shift()](args));
    },
    Home: function() {
      return this.run('Home');
    }
  });
});
