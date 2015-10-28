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
      this.on('render', this.afterRender, this);
      return this.on('show', this.afterShow, this);
    },
    afterRender: function() {
      this.graphCanvas = this.el.querySelectorAll('#viewport')[0];
      this.graphBlock = this.el.querySelectorAll('#community_block5')[0];
      return this.pBlock = this.el.querySelectorAll('p')[0];
    },
    afterShow: function() {
      console.log('On show community');
      return this.graph = new GraphAlgs(this.graphCanvas, this.graphBlock, this.pBlock);
    }
  });
});
