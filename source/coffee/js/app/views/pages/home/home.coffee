define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'

	Template 	= require 'text!tmpls/views/pages/home/home.tpl'

	require 'gsap'

	Marionette.ItemView.extend
		debug		: true
		template 	: Template

		initialize 	: ->
			console.log 'pages/home/home.initialize' if @debug

			@on 'render' , @afterRender , @

		afterRender : ->
			console.log 'page/home/home.afterRender' if @debug

			@initCardsAnimation()

		initCardsAnimation : ->
				
			CSSPlugin.defaultTransformPerspective = 1000;

			elements = @el.querySelectorAll '.lounge'
			console.log elements
			
			Array.prototype.forEach.call elements , ( el , i ) ->
				element = el

				el.addEventListener 'click' , ->
					console.log 'test click'

					#frontCard 	= el
					backCard	= el.querySelector '.lounge-back'

					tl = new TimelineMax paused : true

					tl
					#.to element , 1  , rotationY : 180
					.to backCard  , 1  , rotationY : 0 , 0 
					.to element   , .5 , z : 50 , 0
					.to element   , .5 , z : 0  , .5

					element.animation = tl

					element.animation.play()
				, false