require(['app/app', 'pace'], function(app, pace) {
  'use strict';
  pace.on('start', function() {
    return console.log('pace start');
  });
  return pace.start({
    document: false
  });
});
