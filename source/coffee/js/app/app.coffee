define ['utils/listener','system/animations','components/components','handlebars' , 'models/user'],(Listener,Animations,Components,Handlebars , User)->
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
			@models 		= {}
			@utils 			= {}
			@components 	= Components
			
			@utils.Listener = new Listener {}
			@hostUrl 		= 'http://192.168.1.39:82'
		
		Rivets 	: rivets # Определен в шиме

		preload	: ->
			@models.user = new User()
			console.log 'app/app : preload function ' if @debug; Backbone.history.start()
	
	_.extend app , Animations 													# Компируем в приложение анимации
	app.addInitializer ( options ) 	   -> return @preload() 					# Добавлям инициализатора	
	Marionette.Renderer.render = (t,d) -> tH = Handlebars.compile t; return tH d# Вешаем на рендеринг Handlebars
																			
	return app