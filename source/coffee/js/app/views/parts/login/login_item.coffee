define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/login/login.html'

	require 'gsap'

	View = Marionette.ItemView.extend
		debugAnimation	: true
		debug 			: true
		template 		: Template

		ui :
			'link_registrateFromLogin'	: '.js-registrate-from-login'			
			'link_loginFromRegistrate'	: '.js-login-from-registrate'			

		events :
			'click @ui.link_registrateFromLogin'	: 	'showRegistrateFromLogin'			
			'click @ui.link_loginFromRegistrate'	:	'showLoginFromRegistrate'			

		initialize : ->
			@on 'showLoginFromHeader'	, @showLoginFromHeader , @
			@on 'showRegistrateFromHeader'	, @showRegistrateFromHeader , @
			@on 'hideLogin'	, @hideLogin , @
			@on 'render' 	, @afterRender , @

		afterRender : ->
			@sectionElement = @el.querySelectorAll 		'.autn-section'
			@registerSide 	= @el.querySelector 		'.registr-side'
			@loginSide 		= @el.querySelector 		'.login-side'			
			@scaleElement	= document.getElementById 	'scale-body'	# Элемент который будет уходить назад
			@scaleClass		= 'scale-element' # Клас анимации ухода назад
			@authVisible	= false

			pause = =>
				@dropSectionFromSide.pause()

			CSSPlugin.defaultTransformPerspective = 0

			###*
			# ------------- Анимации выводит блок авторизации -------------
			###
			@dropSectionFromSide = new TimelineMax paused : true
			.addLabel 'startAnimation'
			.set @registerSide , rotationX : -180 
			#.set @el ,{ zIndex : 300  	, display : 'block' }
			#.to @scaleElement 	, .5 	, className : '+=' + @scaleClass , 0
			.to @sectionElement , .3 	, { right : '0%' , alpha : 1 } , 0
			.addLabel 'dropSection'
			.to @registerSide	, .5 	, rotationX : 0 	, 1
			.to @loginSide 		, .5 	, rotationX : 180 	, 1 # Анимация прокручивает секцию до регистраци
			.addLabel 'revertRegistr'

			window.test = @dropSectionFromSide

			# Прослушиваем клик вне логин формы
			@scaleElement.addEventListener 'click' , =>
				# Если анимация не активна и анимирована
				if @sectionDropped()
					# Возвращаем обратно сексию авторизации/регистрации
					@dropSectionFromSide.tweenTo 0


		# Проверяет состоияние сексции выдвинута ли она || анимация не активна и анимирована
		sectionDropped : ->
			return not @dropSectionFromSide.isActive() and @dropSectionFromSide.progress()

		
		showRegistrateFromLogin		: ( event ) ->
			@dropSectionFromSide.tweenTo 'revertRegistr'
			event.preventDefault()

		showRegistrateFromHeader	: ( event ) ->
			@dropSectionFromSide.tweenFromTo 'startAnimation' , 'revertRegistr'

		showLoginFromRegistrate		: ( event ) ->
			@dropSectionFromSide.tweenTo 'dropSection'
			event.preventDefault()

		showLoginFromHeader			: ( event ) ->
			@dropSectionFromSide.tweenFromTo 'startAnimation' , 'dropSection'

	return View