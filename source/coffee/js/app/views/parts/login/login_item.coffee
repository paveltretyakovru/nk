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
			'linkRegistrate' 	: '.js-link-registrate'
			'linkBackLogin' 	: '.js-link-back-login'

		events :
			'click @ui.linkRegistrate' 	: 'showRegistrate'
			'click @ui.linkBackLogin' 	: 'showBackLogin'

		initialize : ->
			@on 'showLogin'	, @showLogin , @
			@on 'hideLogin'	, @hideLogin , @
			@on 'render' 	, @afterRender , @

		afterRender : ->
			sectionElement 	= @el.querySelectorAll 	'.autn-section'
			registerSide 	= @el.querySelector 	'.registr-side'
			loginSide 		= @el.querySelector 	'.login-side'

			# Установка изначальных значений
			TweenMax.set registerSide , rotationX : -180
			###
			TweenMax.set loginSide ,
				filter 			: "blur(0.5px)"
				webkitFilter 	: "blur(0.5px)"
			###
			
			# Анимация выезда блока с авторизацией
			@showBlockLogin = new TimelineMax
				paused : true
			.to sectionElement , 0 , display : 'block' , 0
			.to sectionElement , .3 ,
				right : '0%'
				ease  : Expo.easeInOut
			.paused(true)

			# Анимация поворта блока авторизации на регистрацию
			@showRegisterSide = new TimelineMax 
				paused 		: true
			@showRegisterSide
			.to loginSide 	, 0.5 , rotationX : 180	, 0
			.to registerSide, 0.5 , rotationX : 0	, 0
			
			###
			.to loginSide 	, 0.5,				
				webkitFilter 	: "blur(0)"
				ease 			: "{Power4.easeOut}"
				filter 			: "blur(0)"
			.to registerSide 	, 0.5,
				webkitFilter 	: "blur(0)"
				ease 			: "{Power4.easeOut}"
				filter 			: "blur(0)"
			, 0
			###

		# Возврат на формы входу с формы регистрации
		showBackLogin : ->
			@showRegisterSide.reverse()

		# Выдвигает окно
		showLogin : ->			
			@showBlockLogin.play()			

		# Скрывает окно
		hideLogin : ->			
			@showBlockLogin.reverse()						

		# Поварачивает на сторону регистрации
		showRegistrate : ->						
			@showRegisterSide.play()

	return View