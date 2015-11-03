define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'
	AnimatedModal 	= require 'components/animatedmodal/animatedmodal'

	ComponentItem = Marionette.ItemView.extend
		tagName  : 'table'
		template : "Type component template"

	ForgotPassword = AnimatedModal.extend
		modalContainerView	: new ComponentItem()

	return ForgotPassword