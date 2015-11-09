define(function(require) {
  'use strict';
  var Graph, Graph1, LayoutTemplate, Marionette, Nodes;
  Marionette = require('marionette');
  LayoutTemplate = require('text!tmpls/pages/community/page_community_layoutview.html');
  Nodes = require('views/pages/community/nodes');
  Graph = require('views/pages/community/data');
  Graph1 = require('views/pages/community/data1');
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
      this.nodesLeft = new Nodes('viewport-left', w, h, Graph);
      this.nodesLeft.render;
      this.nodesRight = new Nodes('viewport-right', w, h, Graph1);
      return this.nodesRight.render;
    }
  });
});
