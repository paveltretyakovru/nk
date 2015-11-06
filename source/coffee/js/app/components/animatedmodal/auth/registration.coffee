define ( require ) ->
	'use strict'

	Marionette 				= require 'marionette'
	AnimatedModal 			= require 'components/animatedmodal/animatedmodal'	
	RegistrationTemplate 	= require 'text!tmpls/components/animatedmodal/auth/registrateform.html'
	
	ComponentLogin 			= require 'components/animatedmodal/auth/login'

	RegistrationBodyView 	= Marionette.LayoutView.extend
		template 	: RegistrationTemplate
		
		regions 	: 
			regionAnimatedmodalLogin : '.js-animatedmodal-login'

		initialize : ->
			@on 'render' , @afterRender , @
			
			console.log 'Initialize RegistrationBodyView ' , ComponentLogin
			@loginComponent = new ComponentLogin();			

		afterRender 	: -> 
			console.log 'LOGIN COMMPONENT' , @loginComponent
			@regionAnimatedmodalLogin.show @loginComponent

	RegistrationModal = AnimatedModal.extend
		name 		: 'registration'
		title		: 'Зарегестрироваться'
		bodyView 	: new RegistrationBodyView()

	RegistrationModal