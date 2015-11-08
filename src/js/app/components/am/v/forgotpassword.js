define(['require', 'marionette', 'text!am/tmpl/forgotpassword.html'], function(require, Marionette, Template) {
  'use strict';
  var Model;
  Model = Backbone.Model.extend();
  return Marionette.ItemView.extend({
    template: Template,
    ui: {
      'formForgotpassword': '#form-forgotpassword'
    },
    events: {
      'submit @ui.formForgotpassword': 'doLogin'
    },
    initialize: function() {
      return this.model = new Model();
    },
    onRender: function() {
      return this.binding = app.Rivets.bind(this.el, {
        model: this.model
      });
    },
    doLogin: function(event) {
      $.post(app.hostUrl + '/api/v1/auth/sessions.json', this.model.toJSON(), (function(_this) {
        return function(result) {
          return console.log("result login: ", result);
        };
      })(this));
      return event.preventDefault();
    }
  });
});
