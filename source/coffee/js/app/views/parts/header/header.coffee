define ( require ) ->
	'use strict'

	Marionette 				= require 'marionette'
	Template 				= require 'text!tmpls/parts/header/header.html'
	LoginComponent 			= require 'components/animatedmodal/auth/login'
	RegistrationComponent 	= require 'components/animatedmodal/auth/registration'

	require 'gsap'

	Marionette.LayoutView.extend
		debugAnimation 	: false
		debug			: false
		template 		: Template
		tagName 		: 'header'

		regions :
			regionAnimatedmodalRegistration 	: '.js-animatedmodal-registration'
			regionAnimatedmodalLogin			: '.js-animatedmodal-login'

		ui 	:
			'linkMenu'					: '.js-link-menu'
			'link_loginFromHeader'		: '.js-login-from-header'
			'link_registrateFromHeader'	: '.js-registrate-from-header'

		#events 		: 
		#	'click @ui.linkMenu'					: 'showMenu'
		#	'click @ui.link_loginFromHeader' 		: 'showLoginFromHeader'
		#	'click @ui.link_registrateFromHeader'	: 'showRegistrateFromHeader'

		initialize 	: ->
			# Events
			@on 'render' , @afterRender , @

		onRender : ->
			console.log 'LoginComponent' , LoginComponent			
			@registrationAnimatedModal = new RegistrationComponent()
			#@loginAnimatedModal = new LoginComponent()

		afterRender : ->

		onShow : ->
			#@loginAnimatedModal.on 'render' , ->
			#@regionAnimatedmodalLogin.show @loginAnimatedModal
			
			#@registrationAnimatedModal.on 'render' , ->
			@regionAnimatedmodalRegistration.show @registrationAnimatedModal

		showLoginFromHeader : ( event ) ->
			app.regionAnimatedModal.currentView.trigger 'showLoginFromHeader'
			event.preventDefault()

		showRegistrateFromHeader : ( event ) ->
			app.regionAnimatedModal.currentView.trigger 'showRegistrateFromHeader'
			event.preventDefault()

		showLogin			: ( event ) ->
			console.log 'views/parts/header/header.showLogin : debug' if @debug			
			app.regionAnimatedModal.currentView.trigger 'showLogin'
			@scaleAnimation.play()
			event.preventDefault()

		showRegistration 	: ( event ) ->			
			app.regionAnimatedModal.currentView.trigger 'showLogin'
			@scaleAnimation.play()
			event.preventDefault()

		showMenu 			: ( event ) ->
			console.log 'Show menu' if @debug
			app.regionMenu.currentView.trigger 'showMenu'
			event.preventDefault()