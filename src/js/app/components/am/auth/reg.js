define('am/Reg', ['require', 'exports', 'am', 'am/Login'], function(require, exports, am, amLogin) {
  var amReg;
  amReg = function() {
    return console.log('amregistration module!');
  };
  return exports.amReg = amReg;
});
