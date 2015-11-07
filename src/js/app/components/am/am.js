define(['require', 'exports', 'marionette', 'gsap', 'system/helpers'], function(require, exports, Marionette) {
  'use strict';

  /**
  	 * Сокращения: m-model; c-collection; o-object; am-anmatedmodals; ops-options
  	 * [cP]-коллекция пациентов:) <- ссылки по которыем приклепляются окна
   */
  var c, o;
  c = Backbone.Collection.extend();
  o = Marionette.Object.extend({
    cPevnt: {
      'add': 'takePatient'
    },
    initialize: function() {
      this.cP = new c();
      return Marionette.bindEntityEvents(this, this.cP, this.cPevnt);
    },
    "catch": function(ops) {
      this.options = ops;
      return this.collectPatients();
    },
    collectPatients: function() {
      var el, find, i, results, val;
      el = this.getOption('el');
      find = el != null ? el.querySelectorAll('[data-component=am]') : void 0;
      results = [];
      for (i in find) {
        val = find[i];
        if (isElement(val) && this.getPatient({
          el: val
        }) === void 0) {
          results.push(this.cP.add({
            el: val,
            to: val.getAttribute('data-am-to')
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
    },
    getPatient: function(id) {
      return this.cP.findWhere(id);
    }
  });
  return o;
});
