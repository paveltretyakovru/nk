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
    region: {},
    front: {
      el: {},
      view: {}
    },
    back: {
      el: {},
      view: {}
    },
    current: {
      el: {},
      view: {}
    },
    scaleElement: document.getElementById('scale-body'),
    scaleClass: 'scale-element',
    fullReverseCallback: {},
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
      Marionette.bindEntityEvents(this, this.cM, this.cMevnt);
      this.region = document.createElement('div');
      this.front.el = document.createElement('div');
      this.back.el = document.createElement('div');
      this.region.id = 'region-am';
      this.back.el.id = 'am-back';
      this.front.el.id = 'am-front';
      this.front.el.className = 'am-side';
      this.back.el.className = 'am-side';
      document.body.appendChild(this.region);
      this.region.appendChild(this.back.el);
      this.region.appendChild(this.front.el);
      return this.initAnimation();
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
      link_object.el.addEventListener('click', (function(_this) {
        return function() {
          _this.setCurrent({
            view: link_object.view,
            el: _this.cM.findWhere({
              view: link_object.view
            }).get('viewObj').el
          });
          return _this.showModal(link_object);
        };
      })(this));
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
        if (isElement(val)) {
          results.push(this.cP.add({
            el: val,
            view: val.getAttribute('data-am-view')
          }));
        } else {
          results.push(void 0);
        }
      }
      return results;
    },
    collectModals: function(link_object) {
      if (!this.cM.findWhere({
        view: link_object.view
      })) {
        return this.cM.add({
          view: link_object.view,
          path: 'am/v/' + link_object.view
        });
      }
    },
    takeModal: function(m, c, ops) {
      return require([m.toJSON().path], (function(_this) {
        return function(obj) {
          var viewClass, viewObj;
          viewClass = obj;
          viewObj = new viewClass();
          viewObj.on('render', function() {
            return _this["catch"]({
              el: viewObj.el
            }, _this);
          });
          m.set({
            'view': m.toJSON().view,
            'viewClass': viewClass,
            'viewObj': viewObj
          });
          viewObj.render();
          return console.info('Загружено представление модального окна', m.toJSON().path, m.toJSON());
        };
      })(this), function(err) {
        return console.error('Не удалось загрузить объект модального окна', m.toJSON().path);
      });
    },
    setCurrent: function(options) {
      this.current.el = options.el;
      return this.current.view = options.view;
    },
    setFront: function() {
      this.front.el.innerHTML = '';
      this.front.el.appendChild(this.current.el);
      return this.front.view = this.current.view;
    },
    setBack: function() {
      this.back.el.innerHTML = '';
      this.back.el.appendChild(this.current.el);
      return this.back.view = this.current.view;
    },
    initAnimation: function() {
      this.createAnimation();
      return $(this.scaleElement).on('click', (function(_this) {
        return function(event) {
          var target;
          target = $(event.target);
          if (target.closest(_this.$front).length) {
            return;
          }
          if (target.closest(_this.$back).length) {
            return;
          }
          if (_this.animationDropSides.progress()) {
            return _this.animationDropSides.reverse();
          }
        };
      })(this));
    },
    createAnimation: function() {
      this.animationDropSides = new TimelineMax({
        paused: true,
        onStart: (function(_this) {
          return function() {
            return _this.setFront();
          };
        })(this),
        onReverseComplete: (function(_this) {
          return function() {
            if (_this.animationRotateToBack.progress()) {
              return _this.animationRotateToBack.reverse();
            }
          };
        })(this)
      }).set(this.back.el, {
        rotationX: -180
      }).to(this.scaleElement, .3, {
        className: '+=' + this.scaleClass + ' background-color-overlay'
      }, 0).to(this.front.el, .3, {
        right: '-20%',
        alpha: 1
      }, .3).to(this.back.el, .3, {
        right: '-20%',
        alpha: 1
      }, .3);
      return this.animationRotateToBack = new TimelineMax({
        paused: true,
        onStart: (function(_this) {
          return function() {
            return _this.setBack();
          };
        })(this)
      }).set(this.back.el, {
        rotationX: -180
      }).to(this.back.el, .5, {
        rotationX: 0
      }, .3).to(this.front.el, .5, {
        rotationX: 180
      }, .3);
    },
    showModal: function(options) {
      if (this.animationDropSides.progress()) {
        if (this.animationRotateToBack.progress()) {
          return this.animationRotateToBack.reverse();
        } else {
          return this.animationRotateToBack.play();
        }
      } else {
        return this.animationDropSides.play();
      }
    }
  });
  return o;
});
