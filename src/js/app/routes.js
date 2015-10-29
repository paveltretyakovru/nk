define(function(require) {
  'use strict';
  var Marionette;
  Marionette = require('marionette');
  return window.myRouter = Backbone.Marionette.AppRouter.extend({
    debug: true,
    initialize: function() {
      if (this.debug) {
        return console.log('app/routes.initialize()');
      }
    },
    appRoutes: {
      '': 'Home',
      'about': 'About',
      'community': 'Community',
      'philosophie': 'Philosophie'
    },
    onRoute: function() {
      console.log('onRoute!!!');
      return app.regionMenu.currentView.trigger('hashUpdated');
    }
  });
});
