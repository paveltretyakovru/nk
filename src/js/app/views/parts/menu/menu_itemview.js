define(function(require) {
  'use strict';
  var Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/menu/menu.html');
  return Marionette = Marionette.ItemView.extend({
    debug: true,
    template: Template,
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
      t1.to(body, 0.5, {
        scale: 1,
        webkitFilter: "blur(0)",
        ease: "{Power4.easeOut}"
      }).to(lpm, 1.2, {
        left: "-20%",
        autoAlpha: 0,
        immediateRender: true,
        ease: Expo.easeInOut
      }, 0).to(rpm, 1.2, {
        right: "-20%",
        autoAlpha: 0,
        immediateRender: true,
        ease: Expo.easeInOut
      }, 0).to(bco, 1.2, {
        autoAlpha: 0,
        immediateRender: true,
        ease: Expo.easeInOut
      }, 0);
      return this.closeMenuAnimation = t1;
    }
  });
});
