define ( requrie ) ->
	'use strict'

	require 'gsap'

	Animations = 
		tweens		: {}
		elements	: {}
		animations 	: {}

		initialize 	: ->
			@elements.main 		= document.getElementById 'scale-body'
			@elements.loader 	= document.getElementById 'loader'
			@elements.header 	= document.getElementById 'region-header'
			@elements.content 	= document.getElementById 'region-content'

			TweenMax.set [ @elements.main , @elements.header , @elements.content ]	, autoAlpha : 0

			# Скрытие всего контента
			@animations.hideMain = ( callback ) =>
				@tweens.hideMain = new TimelineMax
					onComplete : =>
						@animations.showLoader =>
							@animations.hideLoader ->
								if callback? then callback()
					paused : true

				@tweens.hideMain
				.set [ @elements.main , @elements.header , @elements.content ] 	, autoAlpha : 1
				.to  @elements.main 	, 2 	, { autoAlpha : 0 , display : 'none' } , 0
				.to  @elements.content 	, 1 	, autoAlpha : 0 , 1
				.to  @elements.header 	, .5 	, autoAlpha : 0 , 1.5
				@tweens.hideMain.play()

			# Появление всего контента
			@animations.showMain = ( callback ) =>
				# Если анимация уже инициализирована
				if @tweens.hideMain? then @tweens.hideMain.reverse()
				else
					# Иначе создаем новую
					@tweens.showMain = new TimelineMax
						onStart : ->							
							if callback? then callback()
						paused 	: true					
					@tweens.showMain.set 	[ @elements.main , @elements.header , @elements.content ] , autoAlpha : 0
					@tweens.showMain.to 	@elements.main 		, 2 	, autoAlpha : 1 , 0
					@tweens.showMain.to 	@elements.header 	, 1 	, autoAlpha : 1 , 1
					@tweens.showMain.to 	@elements.content 	, .5 	, autoAlpha : 1 , 1.5
					@tweens.showMain.play()

			# Показать загрузчик
			@animations.showLoader = ( callback ) =>
				@tweens.showLoader = new TimelineMax paused : true , onComplete : -> callback() if callback?
				@tweens.showLoader.to @elements.loader  , 1 , opacity : 1 , 0

				@tweens.showLoader.play()		

			# Скрыть загрузчик
			@animations.hideLoader = (callback) =>		
				@tweens.hideLoader = new TimelineMax paused : true , onComplete : -> callback() if callback?					
				@tweens.hideLoader.to @elements.loader  , .5 , opacity : 0 , 0

				@tweens.hideLoader.play()

	Animations.initialize()

	return Animations