define(function(require) {
  'use strict';
  var Marionette, Model, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/components/animatedmodal/animatedmodal.html');
  Model = Backbone.Model.extend({
    defaults: {
      title: '[Показать окно]'
    }
  });
  return Marionette.LayoutView.extend({
    template: Template,
    tagName: 'span',
    model: new Model(),
    regions: {
      regionModalContainer: '.js-animatedmodal-modal-container'
    },
    onRender: function() {
      return this.regionModalContainer.show(this.modalContainerView);
    }
  });
});
