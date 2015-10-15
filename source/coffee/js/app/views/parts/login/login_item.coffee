define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/login/login.html'

	View = Marionette.ItemView.extend
		template 	: Template

		ui :
			'linkRegistrate' : '.js-link-registrate'

		events :
			'click @ui.linkRegistrate' : 'showRegistrate'

		initialize : ->
			@on 'showLogin'	, @showLogin , @
			@on 'hideLogin'	, @hideLogin , @
			@on 'render' , @afterRender , @

		afterRender : ->
			sectionElement = @el.querySelectorAll 'section'

			@showBlockLogin = TweenMax.to sectionElement , 1 , right : '0%'
			.paused(true)

		showLogin : ->
			@showBlockLogin.play()

		hideLogin : ->
			@showBlockLogin.reverse()

		showRegistrate : ->
			console.log 'Show registrate'

	return View