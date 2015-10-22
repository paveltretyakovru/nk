define(function(require) {
  'use strict';
  var LayoutTemplate, Marionette;
  Marionette = require('marionette');
  LayoutTemplate = require('text!tmpls/pages/community/page_community_layoutview.html');
  require('onepage-scroll');
  return Marionette.LayoutView.extend({
    template: LayoutTemplate,
    initialize: function() {
      return this.on('render', this.afterRender, this);
    },
    afterRender: function() {}
  });
});
