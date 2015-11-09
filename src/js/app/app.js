define(['utils/listener', 'system/animations', 'components/components', 'handlebars', 'models/user'], function(Listener, Animations, Components, Handlebars, User) {
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
      this.models = {};
      this.utils = {};
      this.components = Components;
      this.utils.Listener = new Listener({});
      return this.hostUrl = 'http://192.168.1.39:82';
    },
    Rivets: rivets,
    preload: function() {
      this.models.user = new User();
      if (this.debug) {
        console.log('app/app : preload function ');
      }
      return Backbone.history.start();
    }
  });
  _.extend(app, Animations);
  app.addInitializer(function(options) {
    return this.preload();
  });
  Marionette.Renderer.render = function(t, d) {
    var tH;
    tH = Handlebars.compile(t);
    return tH(d);
  };
  return app;
});
