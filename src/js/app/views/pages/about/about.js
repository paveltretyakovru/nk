define(function(require) {
  'use strict';
  var ItemView, Marionette, SliderFuncton, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/pages/about/about.html');
  SliderFuncton = require('views/pages/about/slider');
  ItemView = Marionette.ItemView.extend({
    template: Template,
    onShow: function() {
      return SliderFuncton();
    }
  });
  return ItemView;
});
