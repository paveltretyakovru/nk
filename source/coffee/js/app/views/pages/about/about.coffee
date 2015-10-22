define (require) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/pages/about/about.html'

	Marionette.ItemView.extend
		template : Template