define(function(require) {
  'use strict';
  var LoungesCollectionView, Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/views/pages/home/home.tpl');
  LoungesCollectionView = require('views/pages/home/lounges_collectionview');
  require('gsap');
  return Marionette.LayoutView.extend({
    debug: true,
    template: Template,
    regions: {
      regionLounges: '#region-lounges'
    },
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
      this.regionLounges.show(new LoungesCollectionView());
      return this.initCardsAnimation();
    },
    initCardsAnimation: function() {
      var elements;
      CSSPlugin.defaultTransformPerspective = 1000;
      elements = this.el.querySelectorAll('.lounge');
      return Array.prototype.forEach.call(elements, function(el, i) {
        return el.addEventListener('click', function() {
          var backCard, frontCard, tl;
          backCard = el.querySelector('.backside');
          frontCard = el.querySelector('.frontside');
          TweenMax.set(backCard, {
            rotationY: -180
          });
          tl = new TimelineMax({
            paused: true,
            onComplete: function() {
              console.log('Finished animation');
              return app.appRouter.navigate('about', {
                trigger: true
              });
            }
          });
          tl.set(el, {
            zIndex: 200
          }).to(frontCard, 1, {
            rotationY: 180
          }, 0).to(backCard, 1, {
            rotationY: 0
          }, 0);
          el.animation = tl;
          return el.animation.play();
        }, false);
      });
    }
  });
});
