define ( requrie ) ->
	'use strict'

	require 'gsap'

	Animations = 
		tweens		: {}
		elements	: {}
		animations 	: {}
		fastMain 	: true # Быстрый показ

		initialize 	: ->
			@elements.main 		= document.getElementById 'scale-body'
			@elements.loader 	= document.getElementById 'loader'
			@elements.header 	= document.getElementById 'region-header'
			@elements.content 	= document.getElementById 'region-content'

			TweenMax.set [ @elements.main , @elements.header , @elements.content ]	, autoAlpha : 0

			# Скрытие всего контента
			@animations.hideMain = ( callback ) =>
				@tweens.hideMain = new TimelineLite
					onComplete : =>
						@animations.showLoader =>
							@animations.hideLoader ->
								if callback? then callback()
					paused : true

				@tweens.hideMain
				.set [ @elements.main , @elements.header , @elements.content ] 	, autoAlpha : 1
				.to  @elements.content 	, .3 	, autoAlpha : 0 , 0
				.to  @elements.header 	, .3 	, autoAlpha : 0 , .2
				.set @elements.main 	, { autoAlpha : 0 }
				@tweens.hideMain.play()

			# Появление всего контента
			@animations.showMain = ( onstart , callback ) =>
				# Если анимация уже инициализирована
				if @tweens.hideMain? then @tweens.hideMain.reverse()
				else
					# Иначе создаем новую
					@tweens.showMain = new TimelineLite
						onStart : ->							
							if onstart? then onstart()
						onComplete : ->
							if callback? then callback()
						paused 	: true					
					@tweens.showMain.set 	[ @elements.main , @elements.header , @elements.content ] , autoAlpha : 0
					
					if not @fastMain
						@tweens.showMain.to 	@elements.main 		, 2 	, autoAlpha : 1 , 0
						@tweens.showMain.to 	@elements.header 	, 1 	, autoAlpha : 1 , 1
						@tweens.showMain.to 	@elements.content 	, .5 	, autoAlpha : 1 , 1.5
					else
						@tweens.showMain.set 	[@elements.main , @elements.header , @elements.content] , autoAlpha : 1 , 0
						
					@tweens.showMain.play()

			# Показать загрузчик
			@animations.showLoader = ( callback ) =>			

				@elements.backLoaderSVG  = app.elements.loaders[0].getSVGDocument().querySelectorAll 'line'
				@elements.frontLoaderSVG = app.elements.loaders[1].getSVGDocument().querySelectorAll 'path , line ,  circle , polygon'
				
				@tweens.showLoader = new TimelineLite paused : true , onComplete : -> callback() if callback?
				@tweens.showLoader.set [ @elements.frontLoaderSVG , @elements.backLoaderSVG ] 	 , className 	: 'show'
				@tweens.showLoader.to  @elements.loader , 3 , autoAlpha : 1  , 0

				@tweens.showLoader.play()	

			# Скрыть загрузчик
			@animations.hideLoader = (callback) =>
				@tweens.hideLoader = new TimelineLite paused : true , onComplete : -> callback() if callback?		
				@tweens.hideLoader.set [ @elements.frontLoaderSVG , @elements.backLoaderSVG ] 	, className : '-=show'
				@tweens.hideLoader.pause(3)
				@tweens.hideLoader.to  @elements.loader , .1  , { autoAlpha : 0 } , 3

				@tweens.hideLoader.play()

			# Свернуть фон
			@animations.scaleBody = ( callback ) =>
				animation = @tweens.scaleBody
				if callback? then animation.eventCallback 'onComplete' , callback

				animation.play()
				
			#######################################
			### ------ АНИМАЦИИ (tweens) ------ ###
			### Вывел в методы для инкапсуляции ###
			#######################################
			@tweens.scaleBody = @getScaleBody()	# соварчиваем фон

		# Анимацию своварчивания фона
		getScaleBody : ->
			scaleClass 	= 'scale-element'
			
			return TweenLite.to @elements.main , .3 , { className : '+=' + scaleClass + ' background-color-overlay' } , 0
			.paused( true )
			

	Animations.initialize()

	return Animations