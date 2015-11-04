define(function(require) {
  'use strict';
  var AnimatedModal, BackView, FrontView, LoginTemplate, Marionette, RegTemplate;
  Marionette = require('marionette');
  AnimatedModal = require('components/animatedmodal/animatedmodal');
  LoginTemplate = require('text!tmpls/components/animatedmodal/auth/loginform.html');
  RegTemplate = require('text!tmpls/components/animatedmodal/auth/registrateform.html');
  FrontView = Marionette.ItemView.extend({
    template: LoginTemplate
  });
  BackView = Marionette.ItemView.extend({
    template: RegTemplate
  });
  return AnimatedModal.extend({
    title: 'Войти',
    frontView: new FrontView(),
    backView: new BackView()
  });
});
