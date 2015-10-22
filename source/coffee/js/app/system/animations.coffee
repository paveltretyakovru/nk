define ( requrie ) ->
	'use strict'

	require 'gsap'

	Animations = 
		timelines	: {}
		animations 	: {}
		elements	: {}

		initialize 	: ->
			@elements.main 		= document.getElementById 'scale-body'
			@elements.loader 	= document.getElementById 'loader'
			@elements.header 	= document.getElementById 'region-header'
			@elements.content 	= document.getElementById 'region-content'


			@animations.hideMain = ( callback ) =>
				@timelines.hideMain = new TimelineMax
					onComplete : ->
						showLoader ->
							hideLoader ->
								if callback? then callback()
					paused : true

				@timelines.hideMain
				.set @elements.main , autoAlpha : 1
				.to @elements.main 		, .5 ,  { autoAlpha : 0 , display : 'none' }				
				
				@timelines.hideMain.play()

			@animations.showMain = ( callback ) =>
				if @timelines.hideMain? then @timelines.hideMain.reverse()
				else
					@timelines.showMain = new TimelineMax
						onStart : -> if callback? then callback()
						paused 	: true					
					@timelines.showMain.set @elements.main	, autoAlpha : 0
					@timelines.showMain.set @elements.header, autoAlpha : 0
					@timelines.showMain.set @elements.content, autoAlpha : 0
					@timelines.showMain.to 	@elements.main , 2 	, autoAlpha : 1 , 0
					@timelines.showMain.to 	@elements.header , 2 	, autoAlpha : 1 , 0
					@timelines.showMain.to 	@elements.content , 2 	, autoAlpha : 1 , 0
					@timelines.showMain.play()

	Animations.initialize()

	return Animations