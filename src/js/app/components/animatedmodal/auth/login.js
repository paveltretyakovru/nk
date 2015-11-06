define(function(require) {
  'use strict';
  var AnimatedModal, LoginBodyView, LoginModal, LoginTemplate, Marionette, RegistrationComponent;
  Marionette = require('marionette');
  AnimatedModal = require('components/animatedmodal/animatedmodal');
  LoginTemplate = require('text!tmpls/components/animatedmodal/auth/loginform.html');
  RegistrationComponent = require('components/animatedmodal/auth/registration');
  LoginBodyView = Marionette.LayoutView.extend({
    template: LoginTemplate,
    regions: {
      regionAnimatedModalRegistration: '.js-animatedmodal-registration'
    },
    initialize: function() {},
    onShow: function() {
      return this.regionAnimatedModalRegistration.show(new RegistrationComponent());
    }
  });
  LoginModal = AnimatedModal.extend({
    name: 'login',
    title: 'Войти',
    bodyView: new LoginBodyView()
  });
  return LoginModal;
});
