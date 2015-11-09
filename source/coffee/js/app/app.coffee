define ['utils/listener','system/animations','components/components','handlebars'],(Listener,Animations,Components,Handlebars)->
	'use strict'
	
	app = new Marionette.Application
		debug	: true

		regions : 
			regionContent		: '#region-content'
			regionHeader		: '#region-header'
			regionAnimatedModal	: '#region-animated-modal'
			regionMenu 			: '#region-menu'

		initialize : ->
			console.log 'app/app : initializing app' if @debug
			@utils 			= {}
			@utils.Listener = new Listener {}
			@components 	= Components
			@hostUrl 		= 'http://192.168.1.39:82'

		preload	: -> console.log 'app/app : preload function ' if @debug; Backbone.history.start()
		Rivets 	: rivets # Определен в шиме
	
	_.extend app , Animations 													# Компируем в приложение анимации
	app.addInitializer ( options ) 	   -> return @preload() 					# Добавлям инициализатора	
	Marionette.Renderer.render = (t,d) -> tH = Handlebars.compile t; return tH d# Вешаем на рендеринг Handlebars
																			
	return app