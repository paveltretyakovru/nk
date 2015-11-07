define(['require', 'exports', 'marionette', 'gsap', 'system/helpers'], function(require, exports, Marionette) {
  'use strict';

  /**
  	 * Сокращения: m-model; c-collection; o-object; am-anmatedmodals; ops-options
   */
  var c, m, o;
  m = Backbone.Model.extend();
  c = Backbone.Collection.extend({
    model: m
  });
  o = Marionette.Object.extend({
    mEvents: {},
    cEvents: {
      'add': 'takePatient'
    },
    initialize: function(ops) {
      this.options = ops;
      this.m = new m();
      this.c = new c();
      Marionette.bindEntityEvents(this, this.m, this.mEvents);
      Marionette.bindEntityEvents(this, this.c, this.cEvents);
      return this.collectPatients();
    },
    collectPatients: function() {
      var el, f, find, i, results;
      el = this.getOption('el');
      find = el != null ? el.querySelectorAll('[data-component=am]') : void 0;
      results = [];
      for (i in find) {
        f = find[i];
        if (isElement(f)) {
          results.push(this.c.add({
            el: f,
            to: f.getAttribute('data-am-to')
          }));
        } else {
          results.push(void 0);
        }
      }
      return results;
    },
    takePatient: function(m, c, ops) {
      var data;
      return data = m.toJSON();
    }
  });
  return o;
});
