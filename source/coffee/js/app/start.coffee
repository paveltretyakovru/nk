require [ 'app/app' , 'pace' ] , ( app , pace ) ->
	'use strict'	

	window.app	= app || false

	#Показываем загрузчик
	app.animations.showLoader()
	# Закончена загрузка файлов приложения
	pace.on 'done' , -> app.animations.hideLoader -> app.start()
	# Запусками нижний прогрузчик
	pace.start document : false