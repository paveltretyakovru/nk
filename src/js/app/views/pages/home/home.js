define(function(require) {
  'use strict';
  var Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/views/pages/home/home.tpl');
  require('gsap');
  return Marionette.ItemView.extend({
    debug: true,
    template: Template,
    initialize: function() {
      if (this.debug) {
        console.log('pages/home/home.initialize');
      }
      return this.on('render', this.afterRender, this);
    },
    afterRender: function() {
      if (this.debug) {
        console.log('page/home/home.afterRender');
      }
      return this.initCardsAnimation();
    },
    initCardsAnimation: function() {
      var elements;
      CSSPlugin.defaultTransformPerspective = 1000;
      elements = this.el.querySelectorAll('.lounge');
      console.log(elements);
      return Array.prototype.forEach.call(elements, function(el, i) {
        var element;
        element = el;
        return el.addEventListener('click', function() {
          var backCard, tl;
          console.log('test click');
          backCard = el.querySelector('.lounge-back');
          tl = new TimelineMax({
            paused: true
          });
          tl.to(backCard, 1, {
            rotationY: 0
          }, 0).to(element, .5, {
            z: 50
          }, 0).to(element, .5, {
            z: 0
          }, .5);
          element.animation = tl;
          return element.animation.play();
        }, false);
      });
    }
  });
});
