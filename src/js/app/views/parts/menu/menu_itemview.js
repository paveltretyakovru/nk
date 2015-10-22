define(function(require) {
  'use strict';
  var Marionette, Template;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/menu/menu.html');
  return Marionette = Marionette.ItemView.extend({
    debug: true,
    template: Template,
    ui: {
      'ClosingMenuButton': '.js-closing-menu',
      'MenuSiteLinks': '.link-site-menu'
    },
    events: {
      'click @ui.ClosingMenuButton': 'closeMenu',
      'click @ui.MenuSiteLinks': 'closeMenu'
    },
    initialize: function() {
      if (this.debug) {
        console.log('menu_itemvie.initialize');
      }
      this.on('render', this.afterRender, this);
      return this.on('showMenu', this.showMenu, this);
    },
    onRender: function() {
      this.lpm = this.el.querySelectorAll("#lpm");
      this.rpm = this.el.querySelectorAll("#rpm");
      this.scaleBody = document.getElementById('scale-body');
      this.scaleClass = 'scale-element';
      return this.initCloseMenuAnimation();
    },
    afterRender: function() {},
    showMenu: function() {
      return this.closeMenuAnimation.play();
    },
    closeMenu: function() {
      return this.closeMenuAnimation.reverse();
    },
    initCloseMenuAnimation: function() {
      var t1;
      t1 = new TimelineLite({
        paused: true
      });
      t1.to(this.scaleBody, .3, {
        className: '+=' + this.scaleClass
      }, 0).to('#region-menu', .3, {
        autoAlpha: 1,
        ease: Expo.easeInOut
      }, 0).to(this.lpm, .5, {
        left: '0%',
        autoAlpha: 1,
        ease: Expo.easeInOut
      }, .3).to(this.rpm, .5, {
        right: "0%",
        autoAlpha: 1,
        ease: Expo.easeInOut
      }, .5);
      return this.closeMenuAnimation = t1;
    }
  });
});
