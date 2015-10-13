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
	##########################################################################################

	window.app	= app || false
	loader 		= document.getElementById 'loader'

	loader.addEventListener 'webkitAnimationEnd', ( event ) ->
		loader.style.display = 'none' if loader.style.display != 'none'
		app.start()
	, false

	# Начата загрузка файлов приложения
	pace.on 'start' , ->
		console.log 'Pace start' if app.debug

	# Закончена загрузка файлов приложения
	pace.on 'done'	, ->
		console.log 'Pace done' if app.debug
		addClass loader , 'fadeout'

	pace.start
		document : false