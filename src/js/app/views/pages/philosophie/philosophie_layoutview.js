define(function(require) {
  'use strict';
  var LayoutTemplate, Marionette;
  Marionette = require('marionette');
  LayoutTemplate = require('text!tmpls/pages/philosophie/page_philosophie_layoutview.html');
  return Marionette.LayoutView.extend({
    template: LayoutTemplate
  });
});
