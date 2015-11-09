define(['require', 'marionette', 'text!tmpls/pages/profile/profile.html'], function(Require, Marionette, PageTemplate) {
  'use strict';
  var Page;
  Page = Marionette.LayoutView.extend({
    template: PageTemplate
  });
  return Page;
});
