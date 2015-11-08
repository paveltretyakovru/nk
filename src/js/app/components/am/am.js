define(['require', 'exports', 'marionette', 'gsap', 'system/helpers'], function(require, exports, Marionette) {
  'use strict';

  /**
  	 * Сокращения: [m]-model; [c]-collection; [o]-object; [am]-anmatedmodals; [ops]-options
  	 * [cP]-коллекция пациентов:) <- ссылки по которыем приклепляются окна
  	 * [cM]-коллекция модальных окон
   */
  var c, o;
  c = Backbone.Collection.extend();
  o = Marionette.Object.extend({
    el: {},
    cP: {},
    cM: {},
    cPevnt: {
      'add': 'takePatient'
    },
    cMevnt: {
      'add': 'takeModal'
    },
    initialize: function() {
      this.cP = new c();
      this.cM = new c();
      Marionette.bindEntityEvents(this, this.cP, this.cPevnt);
      return Marionette.bindEntityEvents(this, this.cM, this.cMevnt);
    },

    /**
    		 * @param  {mixed} ops должен содерать объект el с селектором для поиска ссылок на анимации
     */
    "catch": function(ops) {
      this.options = ops;
      return this.collectPatients();
    },

    /**
    		 * @return {Void} Подготовка элемента ссылок
     */
    preparePatient: function(link_object) {
      return this.collectModals(link_object);
    },

    /**
    		 * @return {Mixed} Ищет пациента в коллекции]
     */
    getPatient: function(id) {
      return this.cP.findWhere(id);
    },

    /**
    		 * @return {Void} Вызывает метод подготовки новго линка после добавления в коллекцию
     */
    takePatient: function(m, c, ops) {
      return this.preparePatient(m.toJSON());
    },

    /**
    		 * @return {void} добавляет в коллекцию компанентские кнопки
     */
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
    collectModals: function(link_object) {
      if (!this.cM.findWhere({
        to: link_object.to
      })) {
        return this.cM.add({
          to: link_object.to,
          path: 'am/v/' + link_object.to
        });
      }
    },
    takeModal: function(m, c, ops) {
      return require([m.toJSON().path], function(obj) {
        var viewClass;
        viewClass = obj;
        window.view = new viewClass();
        m.set({
          'viewClass': viewClass,
          'view': view
        });
        view.render();
        return console.info('Загружено представление модального окна', m.toJSON().path, m.toJSON());
      }, function(err) {
        return console.error('Не удалось загрузить объект модального окна', m.toJSON().path);
      });
    }
  });
  return o;
});
