define ( require ) ->
	'use strict'

	Marionette = require 'marionette'

	Template 				= require 'text!tmpls/views/pages/home/home.tpl'
	LoungesCollectionView 	= require 'views/pages/home/lounges_collectionview'

	require 'gsap'

	Marionette.LayoutView.extend
		debug		: true
		template 	: Template

		regions 	: 
			regionLounges : '#region-lounges'

		initialize 	: ->
			console.log 'pages/home/home.initialize' if @debug

			@on 'render' , @afterRender , @

		afterRender : ->
			console.log 'page/home/home.afterRender' if @debug

			@regionLounges.show new LoungesCollectionView()

			@initCardsAnimation()

		initCardsAnimation : ->
			CSSPlugin.defaultTransformPerspective = 600
			
			elements 	= @el.querySelectorAll '.lounge'
			Array.prototype.forEach.call elements , ( el , i ) ->				

				el.addEventListener 'click' , ->					
					
					backCard	= el.querySelector '.backside'
					frontCard 	= el.querySelector '.frontside'
					
					TweenMax.set backCard , rotationY : -180

					tl = new TimelineMax 
						paused 		: true
						onComplete	: ->
							console.log 'Finished animation'
							app.appRouter.navigate 'about' , trigger : true
					
					tl
					.set el , zIndex : 200
					#.to frontCard 	, 1 	, rotationY : 180		, 0
					#.to backCard	, 1 	, rotationY : 0			, 0
					#.to el			, .5	, z 		: 200		, 0

					el.animation = tl

					el.animation.play()
				, false