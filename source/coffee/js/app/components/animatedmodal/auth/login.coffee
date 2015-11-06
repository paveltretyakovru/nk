define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'
	AnimatedModal 	= require 'components/animatedmodal/animatedmodal'
	LoginTemplate 	= require 'text!tmpls/components/animatedmodal/auth/loginform.html'

	RegistrationComponent 	= require 'components/animatedmodal/auth/registration'

	LoginBodyView	= Marionette.LayoutView.extend
		template 	: LoginTemplate
		regions 	: 
			regionAnimatedModalRegistration : '.js-animatedmodal-registration'

		initialize 	: ->
			#@render()

		onShow 	: ->
			@regionAnimatedModalRegistration.show new RegistrationComponent()

	LoginModal = AnimatedModal.extend
		name 		: 'login'
		title		: 'Войти'
		bodyView 	: new LoginBodyView()

	return LoginModal