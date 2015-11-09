define(['require', 'marionette', 'text!am/tmpl/achall.html', 'components/am/model'], function(require, Marionette, Template, Model) {
  'use strict';
  return Marionette.ItemView.extend({
    template: Template,
    initialize: function() {
      return this.model = new Model({
        design: true
      });
    }
  });
});
