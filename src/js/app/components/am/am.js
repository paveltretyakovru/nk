define(['require', 'exports', 'marionette', 'gsap', 'system/helpers'], function(require, exports, Marionette) {
  'use strict';

  /**
  	 * Сокращения: m-model; c-collection; o-object; am-anmatedmodals
   */
  var c, m, o;
  m = Backbone.Model.extend();
  c = Backbone.Collection.extend();
  o = Marionette.Object.extend({
    el: {},
    mEvents: {},
    cEvents: {},
    initialize: function(ops) {
      this.options = ops;
      this.m = new m();
      this.c = new c({
        model: this.m
      });
      Marionette.bindEntityEvents(this, this.m, this.mEvents);
      return Marionette.bindEntityEvents(this, this.c, this.cEvents);
    },
    collectPatients: function() {
      if (Marionette.isNodeAttached(this.options.el)) {
        return console.log('Atached!');
      }
    }
  });
  return o;
});
