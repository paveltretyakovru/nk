require(['app/app', 'pace'], function(app, pace) {
  'use strict';
  var imagesSrcs, loaded, preloadObjects;
  loaded = false;
  window.app = app || false;
  preloadObjects = function(datas, objects, callback) {
    var i, j, obj, ref, remaining, results;
    remaining = datas.length;
    results = [];
    for (i = j = 0, ref = remaining; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      obj = document.createElement('object');
      obj.setAttribute('data', datas[i]);
      obj.addEventListener('load', function() {
        --remaining;
        if (remaining <= 0) {
          return callback();
        }
      });
      document.getElementById('loader').appendChild(obj);
      results.push(objects.push(obj));
    }
    return results;
  };
  imagesSrcs = ["src/images/back_loader_logo.svg", "src/images/front_loader_logo.svg"];
  app.elements.loaders = [];
  preloadObjects(imagesSrcs, app.elements.loaders, function() {
    console.log('Images loaded!', app.elements.loaders);
    app.elements.loaders[0].className = 'loader-logo-back';
    app.elements.loaders[1].className = 'loader-logo-front';
    return app.animations.showLoader(function() {
      if (loaded) {
        return app.animations.hideLoader(function() {
          return app.start();
        });
      } else {
        return loaded = true;
      }
    });
  });
  pace.on('done', function() {
    console.log('Pace done callback');
    if (loaded) {
      return app.animations.hideLoader(function() {
        return app.start();
      });
    } else {
      return loaded = true;
    }
  });
  pace.start({
    document: false
  });
  return setTimeout(function() {
    return scrollTo(0, -1);
  }, 0);
});
