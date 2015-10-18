define(function(require) {
  'use strict';
  var Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/menu/menu.html');
  return Marionette = Marionette.ItemView.extend({
    debug: true,
    template: Template,
    ui: {
      'ClosingMenuButton': '.js-closing-menu'
    },
    events: {
      'click @ui.ClosingMenuButton': 'closeMenu'
    },
    initialize: function() {
      if (this.debug) {
        console.log('menu_itemvie.initialize');
      }
      this.on('render', this.afterRender, this);
      return this.on('showMenu', this.showMenu, this);
    },
    afterRender: function() {
      return this.initCloseMenuAnimation();
    },
    showMenu: function() {
      return this.closeMenuAnimation.play();
    },
    closeMenu: function() {
      TweenMax.set('#region-menu', {
        autoAlpha: 1,
        opacity: 1
      });
      return this.closeMenuAnimation.reverse();
    },
    initCloseMenuAnimation: function() {
      var bco, body, lpm, rpm, t1;
      t1 = new TimelineMax({
        paused: true
      });
      lpm = this.el.querySelectorAll("#lpm");
      rpm = this.el.querySelectorAll("#rpm");
      bco = this.el.querySelectorAll("#bco");
      body = document.body;
      this.scaleBody = document.getElementById('scale-body');
      this.scaleClass = 'scale-element';
      t1.to(this.scaleBody, .5, {
        className: this.scaleClass,
        ease: Expo.easeInOut
      }, 0).to('#region-menu', .3, {
        autoAlpha: 1,
        ease: Expo.easeInOut
      }, 0).to(lpm, .3, {
        left: '0%',
        autoAlpha: 1,
        ease: Expo.easeInOut
      }, 0).to(rpm, .3, {
        right: "0%",
        autoAlpha: 1,
        ease: Expo.easeInOut
      }, 0);
      return this.closeMenuAnimation = t1;
    }
  });
});
