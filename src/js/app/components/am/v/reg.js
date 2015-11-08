define(['require', 'marionette', 'text!am/tmpl/reg.html'], function(require, Marionette, Template) {
  'use strict';
  return Marionette.ItemView.extend({
    template: Template
  });
});
