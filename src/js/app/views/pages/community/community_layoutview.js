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
      var h, w;
      w = this.$el.find("#viewport-left").width();
      h = this.$el.find("#viewport-left").height();
      this.nodesLeft = new Nodes('viewport-left', w, h);
      this.nodesLeft.render;
      this.nodesRight = new Nodes('viewport-right', w, h);
      return this.nodesRight.render;
    }
  });
});
