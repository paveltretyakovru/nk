define(['marionette', 'text!tmpls/parts/header/header.html'], function(Marionette, Template) {
  'use strict';
  return Marionette.LayoutView.extend({
    template: Template,
    tagName: 'header',
    className: 'header_menu',
    ui: {
      'linkMenu': '.js-link-menu'
    },
    events: {
      'click @ui.linkMenu': 'showMenu'
    },
    onRender: function() {
      this.am = app.components.am["catch"]({
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
