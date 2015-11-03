define(function(require) {
  'use strict';
  var Animations, Handlebars, Listener, Marionette, app;
  Marionette = require('marionette');
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
      this.utils.Listener = new Listener({});
      return this.hostUrl = 'http://localhost:3000';
    },
    preload: function() {
      if (this.debug) {
        console.log('app/app : preload function ');
      }
      return Backbone.history.start();
    },
    Rivets: rivets
  });
  _.extend(app, Animations);
  app.addInitializer(function(options) {
    return this.preload();
  });
  Marionette.Renderer.render = function(template, data) {
    var toHTML;
    toHTML = Handlebars.compile(template);
    return toHTML(data);
  };
  return app;
});
