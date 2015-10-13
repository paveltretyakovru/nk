define ( require ) ->
	'use strict'

	Marionette = require 'marionette'

	Backbone.Marionette.AppRouter.extend
		debug		: true

		initialize 	: ->
			console.log 'app/routes.initialize()'

		appRoutes 	:
				''			: 'Home'