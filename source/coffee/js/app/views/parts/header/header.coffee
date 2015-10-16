define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/header/header.html'	

	require 'gsap'

	Marionette.ItemView.extend
		debugAnimation 	: false
		debug			: true
		template 		: Template

		ui 	:
			'linkRegistration'	: '.js-link-registration'
			'linkLogin'			: '.js-link-login'
			'linkMenu'			: '.js-link-menu'

		events 		: 
			'click @ui.linkLogin'		: 'showLogin'
			'click @ui.linkRegistration': 'showRegistration'
			'click @ui.linkMenu'		: 'showMenu'

		initialize 	: ->
			# Events
			@on 'render' , @afterRender , @

		afterRender : ->
			# Элемент который будет уходить назад
			@scaleBody 	= document.getElementById 'scale-body'
			@scaleClass	= 'scale-element' # Клас анимации ухода назад						

			@scaleAnimation = TweenMax.to @scaleBody , 0.5 , className : @scaleClass
			.paused(true)

			app.utils.Listener.setClosest 
				id 					: 'clossetOutLogin'
				title 				: 'Клик вне логин формы'
				selector 			: @scaleBody
				
				# Если клик произошел на элемент
				callbackOnElement 	: =>					
					console.log 'scaleAnimation before' , @scaleAnimation.reversed()
					
					app.regionLogin.currentView.trigger 'hideLogin'
					@scaleAnimation.reverse()

					console.log 'scaleAnimation after' , @scaleAnimation.reversed()

		showLogin	: ->
			console.log 'views/parts/header/header.showLogin : debug' if @debug
			
			app.regionLogin.currentView.trigger 'showLogin'
			@scaleAnimation.play()

		showRegistration : ->			
			app.regionLogin.currentView.trigger 'showLogin'			
			@scaleAnimation.play()

		showMenu : ->
			console.log 'Show menu'

			app.regionMenu.currentView.trigger 'showMenu'