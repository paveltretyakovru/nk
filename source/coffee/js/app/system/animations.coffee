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
					@timelines.showMain.to @elements.main , 1 ,  { autoAlpha : 1 }
					@timelines.showMain.play()

	Animations.initialize()

	return Animations