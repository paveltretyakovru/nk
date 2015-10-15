define(function(require) {
  'use strict';
  var Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/header/header.html');
  return Marionette.ItemView.extend({
    debug: true,
    template: Template,
    ui: {
      'linkRegistration': '.js-link-registration',
      'linkLogin': '.js-link-login'
    },
    events: {
      'click @ui.linkLogin': 'showLogin'
    },
    showLogin: function() {
      return console.log('views/parts/header/header.showLogin : debug');
    }
  });
});
