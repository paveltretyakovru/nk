define(['require', 'marionette', 'text!am/tmpl/forgotpassword.html'], function(require, Marionette, Template) {
  'use strict';
  var Model;
  Model = Backbone.Model.extend();
  return Marionette.ItemView.extend({
    template: Template,
    queryUrl: '/api/v1/auth/sessions/forgot',
    ui: {
      'formForgotpassword': '#form-forgotpassword'
    },
    events: {
      'submit @ui.formForgotpassword': 'doForgotpassword'
    },
    initialize: function() {
      return this.model = new Model();
    },
    onRender: function() {
      return this.binding = app.Rivets.bind(this.el, {
        model: this.model
      });
    },
    doForgotpassword: function(event) {
      $.post(app.hostUrl + this.queryUrl, this.model.toJSON(), (function(_this) {
        return function(result) {
          return console.log("result forgotpassword: ", result);
        };
      })(this));
      return event.preventDefault();
    }
  });
});
