define(function(require) {
  'use strict';
  var LayoutTemplate, Marionette, Scrollfade;
  Marionette = require('marionette');
  LayoutTemplate = require('text!tmpls/pages/philosophie/page_philosophie_layoutview.html');
  Scrollfade = require('behaviors/scrollfade/scrollfade');
  return Marionette.LayoutView.extend({
    template: LayoutTemplate,
    behaviors: {
      scrollfade: {
        behaviorClass: Scrollfade
      }
    }
  });
});
