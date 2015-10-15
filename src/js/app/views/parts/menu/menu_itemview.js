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
        return console.log('menu_itemvie.initialize');
      }
    },
    initCloseMenuAnimation: function() {
      var bco, body, lpm, rpm, t1;
      t1 = new TimelineMax({
        paused: true
      });
      lpm = document.getElementById("lpm");
      rpm = document.getElementById("rpm");
      bco = document.getElementById("bco");
      body = document.querySelectorAll('body');
      return t1.to(body, 0.5, {
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
    }
  });
});
