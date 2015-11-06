define(function(require) {
  'use strict';
  var AnimatedModalModule, Marionette, Model, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/components/animatedmodal/animatedmodal.html');
  Model = Backbone.Model.extend({
    defaults: {
      title: '[Показать окно]'
    }
  });
  AnimatedModalModule = Marionette.LayoutView.extend({
    template: Template,
    scaleElement: document.getElementById('scale-body'),
    scaleClass: 'scale-element',
    fullReverseCallback: {},
    regions: {
      regionBodyComponent: '.animatedmodal-side'
    },
    ui: {
      'targetLink': '.js-animate-modal-target'
    },
    events: {
      'click @ui.targetLink': 'showModal'
    },
    initialize: function() {
      console.log('Initialize animatedmodal', this.name);
      this.model = new Model();
      if (!isEmpty(this.title)) {
        this.model.set('title', this.title);
      }
      return this.on('render', this.afterRender, this);
    },
    afterRender: function() {
      console.log('TEST HERE!!!', this.name, this.bodyView);
      this.regionBodyComponent.on('show', this.onRegionBodyComponentShow, this);
      return this.regionBodyComponent.show(this.bodyView);
    },
    onRegionBodyComponentShow: function() {
      this.$front = this.regionBodyComponent.$el;
      console.log('onShow!', this.el, this.$front);
      return this.initAnimations();
    },
    showModal: function(event) {
      this.animationDropSides.play();
      if (event != null) {
        return event.preventDefault();
      }
    },
    initAnimations: function() {
      var _this;
      _this = this;
      this.animationDropSides = new TimelineMax({
        paused: true
      }).to(this.scaleElement, .3, {
        className: '+=' + this.scaleClass + ' background-color-overlay'
      }, 0).to(this.$front, .3, {
        right: '-20%',
        alpha: 1
      }, .3);
      this.animationRotateToBack = new TimelineMax({
        paused: true
      }).to(this.$front, .5, {
        rotationX: 180
      }, .3);
      this.animationDropSides.eventCallback('onReverseComplete', (function(_this) {
        return function() {
          if (_this.toBackRotated()) {
            return _this.animationRotateToBack.reverse();
          } else if (!isEmpty(_this.fullReverseCallback)) {
            _this.fullReverseCallback();
            return _this.fullReverseCallback = {};
          }
        };
      })(this));
      this.animationRotateToBack.eventCallback('onReverseComplete', (function(_this) {
        return function() {
          if (!isEmpty(_this.fullReverseCallback)) {
            _this.fullReverseCallback();
            return _this.fullReverseCallback = {};
          }
        };
      })(this));
      return $(this.scaleElement).on('click', function(event) {
        var target;
        target = $(event.target);
        if (target.closest(_this.$front).length) {
          return;
        }
        if (_this.sidesDroped()) {
          if (target.closest(_this.ui.targetFrontLink).length) {
            _this.fullReverseCallback = _this.showFront;
          }
          if (target.closest(_this.ui.targetBackLink).length) {
            _this.fullReverseCallback = _this.showBack;
          }
          if (target.closest(_this.ui.targetLink).length) {
            _this.fullReverseCallback = _this.showModal;
          }
          return _this.animationDropSides.reverse();
        }
      });
    },
    sidesDroped: function() {
      return !this.animationDropSides.isActive() && this.animationDropSides.progress();
    },
    toBackRotated: function() {
      return !this.animationRotateToBack.isActive() && this.animationRotateToBack.progress();
    },
    rotateModal: function(event) {
      if (this.sidesDroped() && !this.toBackRotated()) {
        this.animationRotateToBack.play();
      } else {
        this.animationRotateToBack.reverse();
      }
      if (event != null) {
        return event.preventDefault();
      }
    },
    showFront: function(event) {
      if (!this.sidesDroped()) {
        this.animationDropSides.play();
      }
      if (event != null) {
        return event.preventDefault();
      }
    },
    showBack: function(event) {
      if (!this.sidesDroped()) {
        this.animationRotateToBack.eventCallback('onComplete', (function(_this) {
          return function() {
            _this.animationDropSides.play();
            return _this.animationRotateToBack.eventCallback('onComplete', null);
          };
        })(this));
        this.animationRotateToBack.play();
      }
      if (event != null) {
        return event.preventDefault();
      }
    },
    initParentData: function(el) {
      var data, result;
      result = {};
      result.data = {};
      data = !isEmpty(el.dataset) ? el.dataset : {};
      result.data.to = 'animatedmodalTo' in data ? data.animatedmodalTo : '';
      console.log('Parent data', result.data);
      return result;
    }
  });
  return AnimatedModalModule;
});
