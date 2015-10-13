define ( require ) ->
	'use strict'

	Marionette = require 'marionette'

	Pages =
		Home	: require 'views/pages/home/home'

	Marionette.Controller.extend
		debug	: true

		initialize : ->
			console.log 'controllers/desktop : initializin function' if @debug

		run : ( pageName , pageParameters ) ->
			console.log 'controllers/desktop.run : route->' + pageName if @debug

			args = Array.prototype.slice.call arguments

			app.regionContent.show( new Pages[ args.shift() ] (args))


		Home 	: -> @.run 'Home'