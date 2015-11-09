define(['require', 'backbone'], function(require, Backbone) {
  'use strict';
  return Backbone.Model.extend({
    defaults: {
      design: false,
      elclose: false
    }
  });
});
