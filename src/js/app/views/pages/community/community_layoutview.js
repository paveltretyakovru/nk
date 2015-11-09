define(function(require) {
  'use strict';
  var LayoutTemplate, Marionette, Nodes;
  Marionette = require('marionette');
  LayoutTemplate = require('text!tmpls/pages/community/page_community_layoutview.html');
  Nodes = require('views/pages/community/nodes');
  return Marionette.LayoutView.extend({
    template: LayoutTemplate,
    className: '.main-wrap',
    initialize: function() {
      return this.on('render', this.afterRender, this);
    },
    onShow: function() {
      this.nodesLeft = new Nodes('viewport-left');
      this.nodesLeft.render;
      this.nodesRight = new Nodes('viewport-right');
      return this.nodesRight.render;
    }
  });
});
