define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/components/animatedmodal/animatedmodal.html'

	Model = Backbone.Model.extend
		defaults :
			title : '[Показать окно]'

	Marionette.LayoutView.extend
		template 			: Template
		tagName 			: 'span'
		model 				: new Model()
		
		regions 	: 
			regionModalContainer : '.js-animatedmodal-modal-container'

		onRender : ->
			@regionModalContainer.show @modalContainerView