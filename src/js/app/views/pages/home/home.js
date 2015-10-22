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
            width: "100vh",
            top: 0,
            left: 0,
            height: "100vh",
            rotationY: 0
<<<<<<< HEAD
          }, 0).to(el, .5, {
            position: "absolute",
            top: 0,
            left: 0,
            width: "100vh",
            height: "100vh"
=======
>>>>>>> 3c4f9b58d4e68f92d1a45bd8c0fa50db64741da4
          }, 0);
          el.animation = tl;
          return el.animation.play();
        }, false);
      });
    }
  });
});
