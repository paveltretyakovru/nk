define(function(require) {
  'use strict';
  var AnimatedModal, ComponentLogin, Marionette, RegistrationBodyView, RegistrationModal, RegistrationTemplate;
  Marionette = require('marionette');
  AnimatedModal = require('components/animatedmodal/animatedmodal');
  RegistrationTemplate = require('text!tmpls/components/animatedmodal/auth/registrateform.html');
  ComponentLogin = require('components/animatedmodal/auth/login');
  RegistrationBodyView = Marionette.LayoutView.extend({
    template: RegistrationTemplate,
    regions: {
      regionAnimatedmodalLogin: '.js-animatedmodal-login'
    },
    initialize: function() {
      this.on('render', this.afterRender, this);
      console.log('Initialize RegistrationBodyView ', ComponentLogin);
      return this.loginComponent = new ComponentLogin();
    },
    afterRender: function() {
      console.log('LOGIN COMMPONENT', this.loginComponent);
      return this.regionAnimatedmodalLogin.show(this.loginComponent);
    }
  });
  RegistrationModal = AnimatedModal.extend({
    name: 'registration',
    title: 'Зарегестрироваться',
    bodyView: new RegistrationBodyView()
  });
  return RegistrationModal;
});
