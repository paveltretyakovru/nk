require(['app/app', 'pace'], function(app, pace) {
  'use strict';
  window.app = app || false;
  app.animations.showLoader();
  pace.on('done', function() {
    return app.animations.hideLoader(function() {
      return app.start();
    });
  });
  return pace.start({
    document: false
  });
});
