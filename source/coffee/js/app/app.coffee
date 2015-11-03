define (require) ->
	'use strict'

	Marionette 	= require 'marionette'
	#Routes     	= require 'app/routes'
	#Desktop    	= require 'controllers/desktop'
	Handlebars 	= require 'handlebars'
	Listener 	= require 'utils/listener'
	Animations  = require 'system/animations'

	require 'system/helpers'
	require 'rivets'
	require 'backbone.rivets'	
	
	app = new Marionette.Application
		debug	: true

		regions :
			regionContent		: '#region-content'
			regionHeader		: '#region-header'
			regionAnimatedModal	: '#region-animated-modal'
			regionMenu 			: '#region-menu'

		initialize : ->
			console.log 'app/app : initializing app' if @debug

			@utils 	= {}
			@utils.Listener = new Listener {}
			@hostUrl = 'http://localhost:3000'

		preload	: ->
			console.log 'app/app : preload function ' if @debug			
			Backbone.history.start()

		Rivets : rivets

	# Компируем в приложение анимации
	_.extend app , Animations

	app.addInitializer ( options ) -> return @preload()					

	Marionette.Renderer.render = ( template , data ) ->
		toHTML = Handlebars.compile template
		return toHTML data

	return app
