define(['require', 'marionette', 'text!am/tmpl/achall.html'], function(require, Marionette, Template) {
  'use strict';
  var Model;
  Model = Backbone.Model.extend();
  return Marionette.ItemView.extend({
    template: Template
  });
});
