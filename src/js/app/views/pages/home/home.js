define(function(require) {
  'use strict';
  var Marionette;
  Marionette = require('marionette');
  return Marionette.ItemView.extend({
    debug: true,
    template: 'small home template',
    initialize: function() {
      if (this.debug) {
        return console.log('pages/home/home.initialize()');
      }
    }
  });
});
