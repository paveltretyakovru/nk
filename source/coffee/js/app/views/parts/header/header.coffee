define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/header/header.html'	

	require 'gsap'

	Marionette.ItemView.extend
		debugAnimation 	: false
		debug			: false
		template 		: Template
		tagName 		: 'header'

		ui 	:
			'linkMenu'					: '.js-link-menu'
			'link_loginFromHeader'		: '.js-login-from-header'
			'link_registrateFromHeader'	: '.js-registrate-from-header'			

		events 		: 
			'click @ui.linkMenu'					: 'showMenu'
			'click @ui.link_loginFromHeader' 		: 'showLoginFromHeader'
			'click @ui.link_registrateFromHeader'	: 'showRegistrateFromHeader'

		initialize 	: ->
			# Events
			@on 'render' , @afterRender , @

		afterRender : ->

		showLoginFromHeader : ( event ) ->
			app.regionLogin.currentView.trigger 'showLoginFromHeader'
			event.preventDefault()

		showRegistrateFromHeader : ( event ) ->
			app.regionLogin.currentView.trigger 'showRegistrateFromHeader'
			event.preventDefault()

		showLogin			: ( event ) ->
			console.log 'views/parts/header/header.showLogin : debug' if @debug			
			app.regionLogin.currentView.trigger 'showLogin'
			@scaleAnimation.play()
			event.preventDefault()

		showRegistration 	: ( event ) ->			
			app.regionLogin.currentView.trigger 'showLogin'
			@scaleAnimation.play()
			event.preventDefault()

		showMenu 			: ( event ) ->
			console.log 'Show menu' if @debug
			app.regionMenu.currentView.trigger 'showMenu'
			event.preventDefault()