require [ 'app/app' , 'pace' , 'app/routes' , 'controllers/desktop' ] , ( app , pace , Routes , Desktop ) ->
	'use strict'
	
	loaded 				= false
	window.app			= app || false	
	window.FAST_LOADER 	= true

	# Предзагрузка изображений
	imagesSrcs 				= [ "src/images/back_loader_logo.svg" , "src/images/front_loader_logo.svg" ]
	app.elements.loaders 	= [  ]
	

	if not FAST_LOADER

		# Ожидаем загрузку SVG прелодеров
		preloadObjects imagesSrcs , app.elements.loaders , ->
			# Устанавливаем им необходимые классы
			app.elements.loaders[0].className = 'loader-logo-back'
			app.elements.loaders[1].className = 'loader-logo-front'
			# Показываем загрузчик
			app.animations.showLoader ->
				if loaded 
					if not FAST_LOADER then	app.animations.hideLoader -> app.appRouter = new Routes controller : new Desktop(); app.start()
					else app.animations.fastHideLoader -> app.appRouter = new Routes controller : new Desktop(); app.start()
				else loaded = true
		
		# Закончена загрузка файлов приложения
		pace.on 'done' , -> 
			if loaded
				app.animations.hideLoader -> app.start()
				document.getElementsByClassName('pace')[0].style.visibility = 'hidden'
			else
				loaded = true

	else		
		# Закончена загрузка файлов приложения
		pace.on 'done' , ->
			app.appRouter = new Routes controller : new Desktop(); app.start()
			document.getElementById('loader').style.visibility = 'hidden'
			document.getElementsByClassName('pace')[0].style.visibility = 'hidden'

	# Запусками нижний прогрузчик
	pace.start document : false
	# Отменям прокрутку при переходе назад
	setTimeout (-> scrollTo( 0 , -1 ) ) , 0