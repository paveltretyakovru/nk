define(['utils/listener', 'system/animations', 'components/components', 'handlebars'], function(Listener, Animations, Components, Handlebars) {
  'use strict';
  var app;
  app = new Marionette.Application({
    debug: true,
    regions: {
      regionContent: '#region-content',
      regionHeader: '#region-header',
      regionAnimatedModal: '#region-animated-modal',
      regionMenu: '#region-menu'
    },
    initialize: function() {
      if (this.debug) {
        console.log('app/app : initializing app');
      }
      this.utils = {};
      this.utils.Listener = new Listener({});
      this.components = Components;
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
