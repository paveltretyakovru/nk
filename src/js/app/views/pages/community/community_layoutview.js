define(function(require) {
  'use strict';
  var LayoutTemplate, Marionette;
  Marionette = require('marionette');
  LayoutTemplate = require('text!tmpls/pages/community/page_community_layoutview.html');
  return Marionette.LayoutView.extend({
    template: LayoutTemplate,
    className: '.main-wrap',
    initialize: function() {},
    onRender: function() {},
    onShow: function() {}
  });
});
