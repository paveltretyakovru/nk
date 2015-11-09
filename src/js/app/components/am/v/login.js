define(['require', 'marionette', 'text!am/tmpl/login.html', 'models/user'], function(require, Marionette, Template, User) {
  'use strict';
  return Marionette.ItemView.extend({
    queryUrl: '/api/v1/auth/sessions',
    template: Template,
    ui: {
      'formLogin': '#form-login'
    },
    events: {
      'submit @ui.formLogin': 'doLogin'
    },
    initialize: function() {
      return this.model = app.models.user;
    },
    onRender: function() {
      return this.binding = app.Rivets.bind(this.el, {
        model: this.model
      });
    },
    doLogin: function(event) {
      $.post(app.hostUrl + this.queryUrl, this.model.toJSON(), (function(_this) {
        return function(result) {
          console.log('RESULT DATA', result);
          if ('id' in result) {
            return _this.successLogin(result);
          } else {
            return _this.errorLogin(result);
          }
        };
      })(this));
      return event.preventDefault();
    },
    successLogin: function(data) {

      /* code */
    },
    errorLogin: function(data) {
      return console.error('Ошибка авторизации', data);
    }
  });
});
