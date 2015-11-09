require(['app/app', 'pace', 'app/routes', 'controllers/desktop'], function(app, pace, Routes, Desktop) {
  'use strict';
  var imagesSrcs, loaded;
  loaded = false;
  window.app = app || false;
  window.FAST_LOADER = true;
  imagesSrcs = ["src/images/back_loader_logo.svg", "src/images/front_loader_logo.svg"];
  app.elements.loaders = [];
  if (!FAST_LOADER) {
    preloadObjects(imagesSrcs, app.elements.loaders, function() {
      app.elements.loaders[0].className = 'loader-logo-back';
      app.elements.loaders[1].className = 'loader-logo-front';
      return app.animations.showLoader(function() {
        if (loaded) {
          if (!FAST_LOADER) {
            return app.animations.hideLoader(function() {
              app.appRouter = new Routes({
                controller: new Desktop()
              });
              return app.start();
            });
          } else {
            return app.animations.fastHideLoader(function() {
              app.appRouter = new Routes({
                controller: new Desktop()
              });
              return app.start();
            });
          }
        } else {
          return loaded = true;
        }
      });
    });
    pace.on('done', function() {
      if (loaded) {
        return app.animations.hideLoader(function() {
          return app.start();
        });
      } else {
        return loaded = true;
      }
    });
  } else {
    pace.on('done', function() {
      app.appRouter = new Routes({
        controller: new Desktop()
      });
      return app.start();
    });
  }
  pace.start({
    document: false
  });
  return setTimeout((function() {
    return scrollTo(0, -1);
  }), 0);
});
