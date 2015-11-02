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
				duration 	: 'right'		# направелние
				time 		: 500			# время появления
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
			@listenEvents()	# Слушаем события и запускаем анимацию при их срабатывании

		###*
		# Метод устанвливает прослушку на необходимые события
		# @return Void
		# @param Function action - параметр указывает обработчик при срабатывания события
		###
		listenEvents 	: ->
			_this = @

			$(window).scroll ->
				# Создаем функцию для отслеживания прокрутки вниз
				setBottomScrollEvent = ( element ) ->	
					bottom_of_object = $( element.$el ).position().top + $( element.$el ).outerHeight()
					bottom_of_window = $(window).scrollTop() + $(window).height()

					if bottom_of_window > bottom_of_object
						console.log 'SHOOOW ELEMENT!!!!'
						_this.play element.$el

				# Подготавливем файлы и запускаем функцию отслеживающую прокрутку вниз
				_this.handleElements setBottomScrollEvent

		###*
		# Метод делает анимацию элемента необходимым способом
		# @return Void
		###
		play 	: ( element ) ->
			# Получаем параметры из тега
			data = @getOptions element			

			# Проверяем тип аниации ( показать , скрыть )
			switch data.type
				when 'hide'					
					# Убираем элемент
					$(element).hide data.effect , data , data.time
				when 'show'
					# Появляем элемент
					$(element).show data.effect , data , data.time

		###*
		# Получаем параметры  data-scrollfade-* из тега
		# @return Object data -> объект с параметрами элемента
		###
		getOptions 	: ( element ) ->
			data 	= {}
			tmp 	= element.dataset

			# Сохраняем параметры в удобном виде а так же заполняем недостующие данные , данными по-умолчанию
			data.effect 	= if tmp.scrollfadeEffect? 	 then tmp.scrollfadeEffect 		else @defaults.animation.effect
			data.duration 	= if tmp.scrollfadeDuration? then tmp.scrollfadeDuration 	else @defaults.animation.duration
			data.time 		= if tmp.scrollfadeTime? 	 then tmp.scrollfadeTime 		else @defaults.animation.time
			data.type 		= if tmp.scrollfadeType? 	 then tmp.scrollfadeType 		else @defaults.animation.type

			return data

		handleElements	: ( callbacks ) ->
			# Дебажить ли эту функцию
			HandleDebug = true

			# Если существуют обработанные элементы
			if @elements.length
				@prepareElements()

			# Если существуют необходимые элемент
			if @elements > 0				
				for i in [0...@elements]

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
					data = @getOptions @ui.FadeTargets[i]

					###
					# Обрабатываем элемент по типу анимации
					###
					
					# Если нужно показать
					@ShowPrepareElement @ui.FadeTargets[i] if data.type == 'show'

					# Сохраняем обработанные элементы
					el 		= {}
					el.$el	= @ui.FadeTargets[i]
					el.data	= data
					@elements.push el
		
		###*
		# Подготовка элемента к появлению
		###
		ShowPrepareElement : ( element ) ->
			console.log 'ShowPrepareElement' , element
			# Если элемент показывается, необходимо сделать его невидимым
			element.css 'display' , 'none'

	return Scrollfade