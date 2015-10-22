require [ 'app/app' , 'pace' ] , ( app , pace ) ->
	'use strict'	

	window.app	= app || false

	$(document).unbind "scroll"

	#Показываем загрузчик
	app.animations.showLoader()
	# Закончена загрузка файлов приложения
	pace.on 'done' , -> app.animations.hideLoader -> app.start()
	# Запусками нижний прогрузчик
	pace.start document : false

	setTimeout ->
        scrollTo 0 , -1
    , 0