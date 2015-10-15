define(function(require) {
  'use strict';
  var Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/header/header.tpl');
  return Marionette.ItemView.extend({
    template: Template
  });
});
