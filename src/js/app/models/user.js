define(['backbone'], function(Backbone) {
  'use strict';
  var User;
  User = Backbone.Model.extend({
    defaults: {
      phone: '',
      password: ''
    }
  });
  return User;
});
