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
			_this = @

			# Элемент который будет уходить назад
			@scaleBody 	= document.getElementById 'scale-body'
			@scaleClass	= 'scale-element' # Клас анимации ухода назад

			# Анимация для отдаления контента при показе формы авторизации
			@scaleAnimation = new TimelineLite
				paused : true
				onComplete : ->
					_this.authVisible = true
				onReverseComplete :->
					_this.authVisible = false

			.to @scaleBody , 0.5 , className : '+=' + @scaleClass		
			
			# Прослушиваем клик вне логин формы
			@scaleBody.addEventListener 'click' , =>
				if @authVisible
					app.regionLogin.currentView.trigger 'hideLogin'
					@scaleAnimation.reverse()

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