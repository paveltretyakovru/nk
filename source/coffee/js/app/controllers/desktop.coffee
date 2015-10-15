define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	HeaderView	= require 'views/parts/header/header'

	Pages =
		Home	: require 'views/pages/home/home'

	Marionette.Controller.extend
		debug	: true

		initialize : ->
			console.log 'controllers/desktop : initializin function' if @debug

		run : ( pageName , pageParameters ) ->
			console.log 'controllers/desktop.run : route->' + pageName if @debug

			args = Array.prototype.slice.call arguments

			Page 	= new Pages[ args.shift() ] args
			Header 	= new HeaderView()

			app.regionContent.show Page
			app.regionHeader.show Header


		Home 	: -> @.run 'Home'