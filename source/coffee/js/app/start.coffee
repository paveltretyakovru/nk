require [ 'app/app' , 'pace' ] , ( app , pace ) ->
	'use strict'

	#########################################################################################
	# Нативная функции добавления класса
	window.addClass = ( el , className ) ->
		if el.classList
			el.classList.add className
		else
			el.className += ' ' + className;

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
		
	##########################################################################################

	window.app	= app || false
	loader 		= document.getElementById 'loader'

	addEvent loader , 'webkitAnimationEnd', ->
		loader.style.display = 'none' if loader.style.display != 'none'
		app.start()

	# Костыль для firefox
	addEvent loader , 'animationend', ->
		loader.style.display = 'none' if loader.style.display != 'none'
		app.start()

	# Начата загрузка файлов приложения
	pace.on 'start' , ->
		console.log 'Pace start' if app.debug

	# Закончена загрузка файлов приложения
	pace.on 'done'	, ->
		console.log 'Pace done' if app.debug
		addClass 	loader , 'fadeout'
		removeClass loader , 'fadein-loader'

	pace.start
		document : false