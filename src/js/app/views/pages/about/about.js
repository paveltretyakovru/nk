define(function(require) {
  'use strict';
  var Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/pages/about/about.html');
  return Marionette.ItemView.extend({
    template: Template
  });
});
