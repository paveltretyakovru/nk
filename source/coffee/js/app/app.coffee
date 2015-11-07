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
			@hostUrl 		= 'http://localhost:3000'

		preload	: -> console.log 'app/app : preload function ' if @debug; Backbone.history.start()
		Rivets 	: rivets # Определен в шиме

	# Компируем в приложение анимации
	_.extend app , Animations
	# Добавлям инициализатора
	app.addInitializer ( options ) -> return @preload()
	# Вешаем на рендеринг Handlebars
	Marionette.Renderer.render = ( template , data ) -> toHTML = Handlebars.compile template; return toHTML data

	return app