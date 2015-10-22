define(function(require) {
  'use strict';
  var Animations, Desktop, Handlebars, Listener, Marionette, Routes, app;
  Marionette = require('marionette');
  Routes = require('app/routes');
  Desktop = require('controllers/desktop');
  Handlebars = require('handlebars');
  Listener = require('utils/listener');
  Animations = require('system/animations');
  require('system/helpers');
  require('rivets');
  require('backbone.rivets');
  app = new Marionette.Application({
    debug: true,
    regions: {
      regionContent: '#region-content',
      regionHeader: '#region-header',
      regionLogin: '#region-login',
      regionMenu: '#region-menu'
    },
    initialize: function() {
      if (this.debug) {
        console.log('app/app : initializing app');
      }
      this.utils = {};
      return this.utils.Listener = new Listener({});
    },
    preload: function() {
      if (this.debug) {
        console.log('app/app : preload function ');
      }
      this.appRouter = new Routes({
        controller: new Desktop()
      });
      return Backbone.history.start();
    },
    Rivets: rivets
  });
  _.extend(app, Animations);
  app.addInitializer(function(options) {
    return this.preload();
  });
  Marionette.Behaviors.behaviorsLookup = function() {
    return window.Behaviors;
  };
  Marionette.Renderer.render = function(template, data) {
    var toHTML;
    toHTML = Handlebars.compile(template);
    return toHTML(data);
  };
  return app;
});
