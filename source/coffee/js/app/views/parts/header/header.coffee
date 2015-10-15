define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/header/header.tpl'

	Marionette.ItemView.extend
		template : Template