define(function(require) {
  'use strict';
  var GraphAlgs, LayoutTemplate, Marionette;
  Marionette = require('marionette');
  LayoutTemplate = require('text!tmpls/pages/community/page_community_layoutview.html');
  GraphAlgs = require('views/pages/community/graphalgs');
  return Marionette.LayoutView.extend({
    template: LayoutTemplate,
    className: '.main-wrap',
    initialize: function() {
      return this.on('render', this.afterRender, this);
    },
    afterRender: function() {
      this.graphCanvas = this.el.querySelectorAll('#viewport')[0];
      this.graphBlock = this.el.querySelectorAll('#community_block5')[0];
      return this.pBlock = this.el.querySelectorAll('p')[0];
    },
    onShow: function() {
      var widthGraph;
      widthGraph = this.graphBlock.offsetWidth;
      this.graphCanvas.setAttribute('width', widthGraph + widthGraph / 100 * 10);
      this.graphCanvas.setAttribute('height', this.graphBlock.offsetHeight);
      return this.graph = new GraphAlgs(this.graphCanvas, 0);
    }
  });
});
