define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/header/header.html'
	ForgotPasswordComponent = require 'components/animatedmodal/forgotpassword/forgotpassword'
	AuthComponent 	= require 'components/animatedmodal/auth/auth'

	require 'gsap'

	Marionette.LayoutView.extend
		debugAnimation 	: false
		debug			: false
		template 		: Template
		tagName 		: 'header'

		regions :
			regionForgotPassword 	: '.js-forgot-from-header'
			regionAuth 				: '.js-auth-animated-modal'

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

		afterRender : ->
			@authComponent 	= new AuthComponent()
			@forgotPassword = new ForgotPasswordComponent()

			window.tComp = @forgotPassword
			window.authComponent  = @authComponent

			@regionForgotPassword.show @forgotPassword
			@regionAuth.show @authComponent

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