define(['require', 'marionette', 'text!am/tmpl/login.html'], function(require, Marionette, Template) {
  'use strict';
  return Marionette.ItemView.extend({
    template: Template
  });
});
