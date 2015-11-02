define(function(require) {
  'use strict';
  var Marionette;
  Marionette = require('marionette');
  return window.Behaviors['test'] = Marionette.Behavior.extend({
    ui: {
      test: '.test'
    },
    events: {
      "click @ui.test": 'showTestMessage'
    },
    showTestMessage: function() {
      return alert('Test alert from Behavior!');
    }
  });
});
