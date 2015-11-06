define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'
	AnimatedModal 	= require 'components/animatedmodal/animatedmodal'

	LoginTemplate 	= require 'text!tmpls/components/animatedmodal/auth/loginform.html'
	RegTemplate 	= require 'text!tmpls/components/animatedmodal/auth/registrateform.html'


	FrontView 		= Marionette.ItemView.extend
		template : LoginTemplate

	BackView 		= Marionette.ItemView.extend
		template : RegTemplate

	AnimatedModal.extend
		# Подпись ссылки
		title		: 'Войти'
		
		# Если необходимо составить переворачиваемое окно
		frontView 	: new FrontView()
		backView 	: new BackView()