require [ 'app/app' , 'pace' ] , ( app , pace ) ->
	'use strict'

	#########################################################################################
	# Нативная функции добавления класса
	window.addClass = ( el , className ) ->
		if el.classList?
			el.classList.add className			
		else
			el.classList += ' ' + className

	window.removeClass = ( el , className ) ->
		if el.classList
			el.classList.remove className
		else
			reg = new RegExp('(^|\\b)' + className.split(' ').join('|') + '(\\b|$)', 'gi')
			el.className = el.className.replace( reg , ' ')

	window.addEvent = ( el , eventName , callback ) ->
		if el.addEventListener
			el.addEventListener eventName , callback , false
		else if el.attachEvent
			console.log 'Attach event'
			el.attachEvent 'on' + eventName , callback

	window.showLoader = ( callback ) ->
		animate = new TimelineMax paused : true , onComplete : -> callback() if callback?
		animate.to loader  , 1 , opacity : 1 , 0

		animate.play()		

	window.hideLoader = (callback) ->		
		animate = new TimelineMax paused : true , onComplete : -> callback() if callback?					
		animate.to loader  , .5 , opacity : 0 , 0

		animate.play()
		
	##########################################################################################

	window.app	= app || false
	loader 		= document.getElementById 'loader'
	main 		= document.getElementById 'scale-body'
	header 		= document.getElementById 'region-header'
	content 	= document.getElementById 'region-content'

	TweenMax.set main	, autoAlpha : 0
	TweenMax.set header, autoAlpha : 0
	TweenMax.set content, autoAlpha : 0

	showLoader()

	# Закончена загрузка файлов приложения
	pace.on 'done' , -> hideLoader -> app.start()

	pace.start
		document : false