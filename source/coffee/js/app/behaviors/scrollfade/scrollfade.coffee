define ( require ) ->
	'use strict'

	Marionette = require 'marionette'


	require 'jquery-ui'

	Scrollfade = Marionette.Behavior.extend
		# Подготовленные элементы для бехейвера
		elements : []

		# Установка параметров по-умолчанию
		defaults : 
			# Параметры анимации
			animation :
				effect 		: 'bounce'		# http://jqueryui.com/show/
				direction 	: 'right'		# направелние
				time 		: 1000			# время появления
				type 		: 'show'		# тип show - появление , hide - исчезновение

		ui :
			'FadeTargets' : '.js-scrollfade'

		events :
			"click @ui.FadeTargets" : 'showTestMessage'

		showTestMessage : (e) -> @play e.currentTarget

		###*
		# Метод отрабатывает при появляении страницы, можно сказать старт
		# @return Void
		###
		onShow : ->
			@prepareElements()
			@listenEvents()	# Слушаем события и запускаем анимацию при их срабатывании

		###*
		# Метод устанвливает прослушку на необходимые события
		# @return Void
		# @param Function action - параметр указывает обработчик при срабатывания события
		###
		listenEvents 	: ->
			_this = @
			
			# Создаем функцию для отслеживания прокрутки вниз
			setBottomScrollEvent = ( element ) ->	
				$(window).scroll ->
					#console.log 'setBottomScrollEvent' , element
					bottom_of_object = element.data.topJS
					bottom_of_window = $(window).scrollTop() + $(window).height()

					console.log 'BOTTOM' , bottom_of_window , bottom_of_object

					if bottom_of_window > bottom_of_object
						_this.play element

			# Подготавливем файлы и запускаем функцию отслеживающую прокрутку вниз
			_this.handleElements setBottomScrollEvent

		###*
		# Метод делает анимацию элемента необходимым способом
		# @return Void
		###
		play 	: ( element ) ->			
			# Проверяем тип аниации ( показать , скрыть )
			switch element.data.type
				when 'hide'
					# Убираем элемент
					element.$el.hide element.data.effect , element.data
				when 'show'
					# Появляем элемент
					element.$el.show element.data.effect , element.data

		###*
		# Получаем параметры  data-scrollfade-* из тега
		# @return Object data -> объект с параметрами элемента
		###
		getOptions 	: ( element ) ->
			data 	= {}
			tmp 	= element.el.dataset

			# Сохраняем параметры в удобном виде а так же заполняем недостующие данные , данными по-умолчанию
			data.effect 	= if tmp.scrollfadeEffect? 	 	then tmp.scrollfadeEffect 			else @defaults.animation.effect
			data.direction 	= if tmp.scrollfadeDirection? 	then tmp.scrollfadeDirection 		else @defaults.animation.direction
			data.duration	= if tmp.scrollfadeTime? 	 	then parseInt(tmp.scrollfadeTime) 	else @defaults.animation.time
			data.type 		= if tmp.scrollfadeType? 	 	then tmp.scrollfadeType 			else @defaults.animation.type
			data.topJS	= element.$el.offset().top

			console.log 'DATA' , data

			return data

		handleElements	: ( callbacks ) ->
			# Дебажить ли эту функцию
			HandleDebug = false

			# Если существуют обработанные элементы
			if not @elements.length				
				@prepareElements()

			# Если существуют необходимые элемент
			if @elements.length > 0				
				for i in [0...@elements.length]

					# callback function
					if isFunction callbacks
						console.log 'behaviors/scrollfade.handleDebug(): This is [FUNCTION] callback' if HandleDebug
						callbacks @elements[i]

					# array with callbacks functions
					else if isArray callbacks
						console.log 'behaviors/scrollfade.handleDebug(): This is [ARRAY] callbacks' if HandleDebug
						for n of callbacks
							if not callbacks.hasOwnProperty i then continue
							callbacks[n] @elements[i]

					# if is object method
					else if isString(callbacks) and callbacks? and callbacks in @
						console.log 'behaviors/scrollfade.handleDebug(): This is [STRING] callback' if HandleDebug

		###*
		# Метод подготавливает элементы перед навешиванием событий
		###
		prepareElements : ->
			@elements = []
			if @ui.FadeTargets.length > 0
				for i in [0...@ui.FadeTargets.length]

					# Сохраняем обработанные элементы
					el 		= {}
					el.el 	= @ui.FadeTargets[i]
					el.$el	= $ @ui.FadeTargets[i]
					el.data	= @getOptions el
					@elements.push el

					###
					# Обрабатываем элемент по типу анимации
					###
					# -> Если нужно показать
					@ShowPrepareElement el if el.data.type == 'show'

		###*
		# Подготовка элемента к появлению
		###
		ShowPrepareElement : ( element ) ->
			# Если элемент показывается, необходимо сделать его невидимым
			element.$el.css 'display' , 'none'

	return Scrollfade