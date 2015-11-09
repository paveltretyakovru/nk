define(['require', 'marionette', 'text!tmpls/pages/profile/profile.html'], function(Require, Marionette, PageTemplate) {
  'use strict';
  var Page;
  Page = Marionette.LayoutView.extend({
    template: PageTemplate,
    onRender: function() {
      this.am = app.components.am["catch"]({
        el: this.el
      });
      return window.am = this.am;
    }
  });
  return Page;
});
