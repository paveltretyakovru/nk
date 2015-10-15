define(function(require) {
  'use strict';
  var Marionette, View;
  Marionette = require('marionette');
  View = Marionette.ItemView.extend({
    template: 'TEMPLATE LOGIN'
  });
  return View;
});
