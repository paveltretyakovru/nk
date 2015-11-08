define(['require', 'marionette', 'text!am/tmpl/reg.html'], function(require, Marionette, Template) {
  'use strict';
  var Model;
  Model = Backbone.Model.extend();
  return Marionette.ItemView.extend({
    template: Template,
    queryUrl: '/api/v1/auth/registrations',
    ui: {
      'formReg': '#form-reg'
    },
    events: {
      'submit @ui.formReg': 'doReg'
    },
    initialize: function() {
      return this.model = new Model();
    },
    onRender: function() {
      return this.binding = app.Rivets.bind(this.el, {
        model: this.model
      });
    },
    doReg: function(event) {
      $.post(app.hostUrl + this.queryUrl, this.model.toJSON(), (function(_this) {
        return function(result) {
          return console.log("result reg: ", result);
        };
      })(this));
      return event.preventDefault();
    }
  });
});
