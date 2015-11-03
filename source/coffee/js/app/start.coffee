require [ 'app/app' , 'pace' , 'app/routes' , 'controllers/desktop' ] , ( app , pace , Routes , Desktop ) ->
	'use strict'
	
	loaded 				= false
	window.app			= app || false	
	window.FAST_LOADER 	= true

	# Функция загружает массив данных и выполняет callback после всех загруженных
	preloadObjects = ( datas , objects , callback ) ->
		remaining = datas.length

		for i in [0...remaining]
			obj 	= document.createElement 'object'
			obj.setAttribute 'data' , datas[i]
			obj.addEventListener 'load' , ->
				--remaining
				callback() if remaining <= 0			
			document.getElementById('loader').appendChild(obj)
			objects.push obj
	#________________________________________________


	imagesSrcs 				= [ "src/images/back_loader_logo.svg" , "src/images/front_loader_logo.svg" ]
	app.elements.loaders 	= [  ]
	
	# Ожидаем загрузку SVG прелодеров
	preloadObjects imagesSrcs , app.elements.loaders , ->
		console.log 'Images loaded!' , app.elements.loaders
		
		# Устанавливаем им необходимые классы
		app.elements.loaders[0].className = 'loader-logo-back'
		app.elements.loaders[1].className = 'loader-logo-front'

		# Показываем загрузчик
		app.animations.showLoader ->
			if loaded 
				if not FAST_LOADER
					app.animations.hideLoader ->
						app.appRouter = new Routes controller : new Desktop()
						app.start()
				else
					app.animations.fastHideLoader ->
						app.appRouter = new Routes controller : new Desktop()
						app.start()

			else loaded = true
	
	# Закончена загрузка файлов приложения
	pace.on 'done' , ->
		console.log 'Pace done callback'
		if loaded then app.animations.hideLoader -> app.start() else loaded = true
	
	# Запусками нижний прогрузчик
	pace.start document : false

	setTimeout ->
        scrollTo 0 , -1
    , 0