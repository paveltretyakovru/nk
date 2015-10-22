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
			
			Array.prototype.forEach.call elements , ( el , i ) ->				

				el.addEventListener 'click' , ->

					backCard	= el.querySelector '.backside'
					frontCard 	= el.querySelector '.frontside'
					
					TweenMax.set backCard , rotationY : -180

					tl = new TimelineMax 
						paused 		: true
					tl
					.to frontCard 	, 1 	, rotationY : 180		, 0
					.to backCard	, 1 	, {width: "100vh", top: 0, left: 0, height: "100vh", rotationY : 0}, 0
					.to el			, .5	, {position: "absolute", top: 0, left: 0, width: "100vh", height: "100vh"}, 0	
					#.to el 			, .5	, z 		: 0			, .5

					el.animation = tl

					el.animation.play()
				, false