define(function(require) {
  'use strict';
  var AnimatedModal, ComponentItem, Marionette;
  Marionette = require('marionette');
  AnimatedModal = require('components/animatedmodal/animatedmodal');

  /**
  	 * Манипуляция через шаблон
   */
  ComponentItem = Marionette.ItemView.extend({
    template: "Type component template"
  });
  return AnimatedModal.extend({
    title: 'Забыли пароль?',
    bodyView: new ComponentItem()
  });
});
