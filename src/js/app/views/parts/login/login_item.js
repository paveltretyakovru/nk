define(function(require) {
  'use strict';
  var Marionette, Template, View;
  Marionette = require('marionette');
  Template = require('text!tmpls/parts/login/login.html');
  require('gsap');
  View = Marionette.ItemView.extend({
    debugAnimation: true,
    debug: true,
    template: Template,
    ui: {
      'linkRegistrate': '.js-link-registrate',
      'linkBackLogin': '.js-link-back-login'
    },
    events: {
      'click @ui.linkRegistrate': 'showRegistrate',
      'click @ui.linkBackLogin': 'showBackLogin'
    },
    initialize: function() {
      this.on('showLogin', this.showLogin, this);
      this.on('hideLogin', this.hideLogin, this);
      return this.on('render', this.afterRender, this);
    },
    afterRender: function() {
      var loginSide, registerSide, sectionElement;
      sectionElement = this.el.querySelectorAll('.autn-section');
      registerSide = this.el.querySelector('.registr-side');
      loginSide = this.el.querySelector('.login-side');
      TweenMax.set(registerSide, {
        rotationX: -180

        /*
        			TweenMax.set loginSide ,
        				filter 			: "blur(0.5px)"
        				webkitFilter 	: "blur(0.5px)"
         */
      });
      this.showBlockLogin = new TimelineMax({
        paused: true
      }).to(sectionElement, 0, {
        display: 'block'
      }, 0).to(sectionElement, .3, {
        right: '0%',
        ease: Expo.easeInOut
      }).paused(true);
      this.showRegisterSide = new TimelineMax({
        paused: true
      });
      return this.showRegisterSide.to(loginSide, 0.5, {
        rotationX: 180
      }, 0).to(registerSide, 0.5, {
        rotationX: 0
      }, 0);

      /*
      			.to loginSide 	, 0.5,				
      				webkitFilter 	: "blur(0)"
      				ease 			: "{Power4.easeOut}"
      				filter 			: "blur(0)"
      			.to registerSide 	, 0.5,
      				webkitFilter 	: "blur(0)"
      				ease 			: "{Power4.easeOut}"
      				filter 			: "blur(0)"
      			, 0
       */
    },
    showBackLogin: function() {
      return this.showRegisterSide.reverse();
    },
    showLogin: function() {
      return this.showBlockLogin.play();
    },
    hideLogin: function() {
      return this.showBlockLogin.reverse();
    },
    showRegistrate: function() {
      return this.showRegisterSide.play();
    }
  });
  return View;
});
