define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/header/header.html'	

	require 'gsap'

	Marionette.ItemView.extend
		debug		: true
		template 	: Template

		ui 	:
			'linkRegistration'	: '.js-link-registration'
			'linkLogin'			: '.js-link-login'

		events 		: 
			'click @ui.linkLogin'	: 'showLogin'

		initialize 	: ->
			# Events
			@on 'render' , @afterRender , @				

		afterRender : ->
			# Элемент который будет уходить назад
			@scaleBody 	= document.getElementById 'scale-body'
			@scaleClass	= 'scale-element' # Клас анимации ухода назад						

			@scaleAnimation = TweenMax.to @scaleBody , 1 , className : @scaleClass
			.paused(true)

			app.utils.Listener.setClosest 
				id 					: 'clossetOutLogin'
				title 				: 'Клик вне логин формы'
				selector 			: @scaleBody
				# Если клик произошел на элемент
				callbackOnElement 	: =>					
					app.regionLogin.currentView.trigger 'hideLogin'
					@scaleAnimation.reverse()

		showLogin	: ->
			console.log 'views/parts/header/header.showLogin : debug' if @debug
			app.regionLogin.currentView.trigger 'showLogin'
			@scaleAnimation.play()
			