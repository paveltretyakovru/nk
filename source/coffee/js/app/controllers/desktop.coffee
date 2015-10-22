define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	HeaderView	= require 'views/parts/header/header'
	LoginView	= require 'views/parts/login/login_item'
	MenuView 	= require 'views/parts/menu/menu_itemview'	

	Pages =
		Home		: require 'views/pages/home/home'
		About		: require 'views/pages/about/about'
		Community	: require 'views/pages/community/community_layoutview'

	Marionette.Controller.extend
		debug	: false
		hidden 	: true

		initialize : ->
			console.log 'controllers/desktop : initializin function' if @debug
			@Header = new HeaderView()
			@Login 	= new LoginView()
			@Menu 	= new MenuView()

			app.regionHeader.show @Header
			app.regionLogin.show @Login
			app.regionMenu.show @Menu

			app.regionContent.on 'show' , ->
				app.animations.showMain()

		run : ( pageName , pageParameters ) ->
			console.log 'controllers/desktop.run : route->' + pageName if @debug

			args = Array.prototype.slice.call arguments
			Page = new Pages[ args.shift() ] args
			
			if @hidden
				app.animations.showMain ->
					app.regionContent.show Page
				@hidden = false
			else
				app.animations.hideMain ->
					app.regionContent.show Page

		Home 		: -> @.run 'Home'
		About 		: -> @.run 'About'
		Community 	: -> @.run 'Community'