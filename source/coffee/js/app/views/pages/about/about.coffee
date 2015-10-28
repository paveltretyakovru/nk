define (require) ->
	'use strict'

	Marionette 		= require 'marionette'
	Template 		= require 'text!tmpls/pages/about/about.html'	

	SliderFuncton 	= require 'views/pages/about/slider'

	ItemView = Marionette.ItemView.extend
		template : Template

		onShow : ->
			SliderFuncton()

	return ItemView