define(function(require) {
  'use strict';
  var Desktop, Handlebars, Marionette, Routes, app;
  Marionette = require('marionette');
  Routes = require('app/routes');
  Desktop = require('controllers/desktop');
  Handlebars = require('handlebars');
  require('system/helpers');
  require('rivets');
  require('backbone.rivets');
  app = new Marionette.Application({
    debug: true,
    regions: {
      regionContent: '#region-content'
    },
    initialize: function() {
      if (this.debug) {
        return console.log('app/app : initializing app');
      }
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
  app.addInitializer(function(options) {
    return this.preload();
  });
  app.regionContent.on('show', function() {
    console.log('TEeeeeeeest');
    removeClass(app.regionContent.el, 'fadeout');
    return addClass(app.regionContent.el, 'fadein');
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
