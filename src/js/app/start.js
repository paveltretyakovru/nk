require(['app/app', 'pace'], function(app, pace) {
  'use strict';
  window.app = app || false;
  $(document).unbind("scroll");
  app.animations.showLoader();
  pace.on('done', function() {
    return app.animations.hideLoader(function() {
      return app.start();
    });
  });
  pace.start({
    document: false
  });
  return setTimeout(function() {
    return scrollTo(0, -1);
  }, 0);
});
