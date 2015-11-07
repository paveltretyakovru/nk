define(['require', 'marionette', 'text!am/tmpl/reg.html'], function(require, Marionette, Template) {
  'use strict';
  return Marionette.LayoutView.extend({
    tempalte: Template
  });
});
