define(['marionette', 'text!tmpls/parts/header/header.html'], function(Marionette, Template) {
  'use strict';
  return Marionette.LayoutView.extend({
    template: Template,
    tagName: 'header',
    ui: {
      'linkMenu': '.js-link-menu'
    },
    events: {
      'click @ui.linkMenu': 'showMenu'
    },
    onRender: function() {
      this.am = new app.components.am({
        el: this.el
      });
      return window.am = this.am;
    },
    showMenu: function(event) {
      app.regionMenu.currentView.trigger('showMenu');
      return event.preventDefault();
    }
  });
});
