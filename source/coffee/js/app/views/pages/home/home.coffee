define ( require ) ->
	'use strict'

	Marionette = require 'marionette'

	Marionette.ItemView.extend
		debug		: true
		template 	: 'small home template'

		initialize 	: ->
			console.log 'pages/home/home.initialize()' if @debug