define(function(require) {
  'use strict';
  var Marionette, Model, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/components/animatedmodal/animatedmodal.html');
  Model = Backbone.Model.extend({
    defaults: {
      title: '[Показать окно]'
    }
  });
  return Marionette.LayoutView.extend({
    template: Template,
    model: new Model(),
    className: 'animate-modal-parent',
    bodyView: {},
    frontView: {},
    backView: {},
    regions: {
      regionFront: '.js-animate-modal-front',
      regionBack: '.js-animate-modal-back'
    },
    ui: {
      'targetLink': '.js-animate-modal-target',
      'rotateLink': '.js-animate-modal-rotate',
      'targetBackLink': '.js-animate-modal-target-back',
      'targetFrontLink': '.js-animate-modal-target-front'
    },
    events: {
      'click @ui.targetLink': 'showModal',
      'click @ui.rotateLink': 'rotateModal',
      'click @ui.targetBackLink': 'showBack',
      'click @ui.targetFrontLink': 'showFront'
    },
    initialize: function() {
      this.scaleElement = document.getElementById('scale-body');
      this.fullReverseCallback = {};
      if (!isEmpty(this.title)) {
        this.model.set('title', this.title);
      }
      return this.on('render', this.afterRender, this);
    },
    onRender: function() {
      if (!isEmpty(this.bodyView)) {
        return this.regionFront.show(this.bodyView);
      } else if (!isEmpty(this.frontView) && !isEmpty(this.backView)) {
        this.regionFront.show(this.frontView);
        return this.regionBack.show(this.backView);
      }
    },
    afterRender: function() {
      var _this;
      _this = this;
      this.$front = this.regionFront.$el;
      this.$back = this.regionBack.$el;
      this.initAnimations();
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
        if (target.closest(_this.$back).length) {
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
    showModal: function(event) {
      this.animationDropSides.play();
      if (event != null) {
        return event.preventDefault();
      }
    },
    initAnimations: function() {
      this.animationDropSides = new TimelineMax({
        paused: true
      }).to(this.$front, .3, {
        right: '-20%',
        alpha: 1
      }, 0).to(this.$back, .3, {
        right: '-20%',
        alpha: 1
      }, 0);
      return this.animationRotateToBack = new TimelineMax({
        paused: true
      }).set(this.$back, {
        rotationX: -180
      }).to(this.$back, .5, {
        rotationX: 0
      }, .3).to(this.$front, .5, {
        rotationX: 180
      }, .3);
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
    }
  });
});
