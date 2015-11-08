define ( require ) ->
	'use strict'

	Marionette = require 'marionette'

	window.myRouter = Backbone.Marionette.AppRouter.extend
		debug		: true

		initialize 	: ->
			console.log 'app/routes.initialize()' if @debug

		appRoutes 	:
				''				: 'Home'
				'about'			: 'About'
				'community' 	: 'Community'
				'philosophie'	: 'Philosophie'
				'profile'		: 'Profile'

		# Событие при смены роутов
		onRoute : ->
			# Обновление стилей ссылок в меню
			app.regionMenu.currentView.trigger 'hashUpdated'

