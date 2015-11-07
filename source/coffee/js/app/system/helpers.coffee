define ( require ) ->
	'use strict'

	Handlebars 	= require('handlebars')
	I18n 		= require('utils/i18n')
	NumFormat 	= require('system/libs/num_format')

	#########################################################################################
	
	###*
	 * Функция загружает массив данных и выполняет callback после всех загруженных
	 * @param  {array}   	datas    Массив с путями изображений
	 * @param  {array}   	objects  ПУстой глобальный массив для сохранения объектов
	 * @param  {Function} 	callback Ответная функция после загрузки всех нужных изображений
	 * @return {Void}       Заполняет массив object новыми объектами с изображениями и выполняет callback     
	###
	window.preloadObjects = ( datas , objects , callback ) ->
		remaining = datas.length

		for i in [0...remaining]
			obj = document.createElement 'object'
			obj.setAttribute 'data' , datas[i]
			obj.addEventListener 'load' , ->
				--remaining
				callback() if remaining <= 0			
			document.getElementById('loader').appendChild(obj)
			objects.push obj

	###*
	 * #Returns true if it is a DOM node
	 * @param  {mixed}  	o mixed data for check
	 * @return {Boolean}   	if 'o' is dom node -> TRUE else FALSE
	###
	isNode = (o) ->
		return if typeof Node == 'object' then o instanceof Node else o && typeof o == 'object' && typeof o.nodeType == 'number' && typeof o.nodeName == 'string'

	###*
	 * Returns true if it is a DOM element
	 * @param  {mixed}  'o' mixed data for check
	 * @return {Boolean}   if 'o' is dom element -> TRUE else FALSE
	###
	window.isElement = (o) ->
		return if typeof HTMLElement == "object" then o instanceof HTMLElement else o and typeof o == "object" and o != null and o.nodeType == 1 and typeof o.nodeName == "string"

	window.isString = ( variable ) ->
		return typeof variable == "string"

	window.isArray = ( variable ) ->
		return Array.isArray variable

	window.isFunction = ( functionToCheck ) ->
		getType = {}
		return functionToCheck && getType.toString.call(functionToCheck) == '[object Function]'

	###*
	 * Прооверяет obj на пустоту
	 * @param  {mixed} переменная для проверки на пустоту
	 * @return {Boolean}
	###
	hasOwnProperty = Object.prototype.hasOwnProperty
	window.isEmpty = ( obj ) ->
		return true 	if obj == null
		return false 	if obj.length > 0
		return true 	if obj.length == 0

		for key of obj
			return false if hasOwnProperty.call obj , key
		return true

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

	window.randomInteger = ( min , max ) ->
		rand = min + Math.random() * (max - min)
		rand = Math.round rand
		return rand

	window.findAttr = ( selector , findin ) ->
		matchingElements 	= []
		allElements 		= if findin? then findin else document.getElementsByTagName '*'		
		arr					= selector.split('=')

		if arr.length > 1
			attr = arr[0]
			attrValue = arr[1]
		else
			attrValue = arr[0]

		for i in [0...allElements.length]
			# Если сущестует название атрибу
			if attr?
				elemAttr = allElements[i].getAttribute attr
				if elemAttr?
					if elemAttr == attrValue
						matchingElements.push allElements[i]
			else
				console.error "Неправильный формат параметра переданного в функцию"		

		

		return matchingElements

	window.getHashValue = ( key ) ->
		matches = location.hash.match new RegExp(key+'=([^&]*)')
		return if matches then matches[1] else null
		
	##########################################################################################

	###*
	# Хелпер для интернационализации
	# @param  {String}     Ключ для поиска перевода
	# @return {string}     Найденный перевод в словаре
	# @author  Aleksandr Vasilenko <info@acset.ru>
	###

	Handlebars.registerHelper 'I18n', (str) ->
		if typeof I18n != 'undefined' then I18n.t(str) else str

	###*
	# Хелпер для форматирования цен
	# @param  {int}        Цена
	# @return {string}     Форматированную цену с валютой
	# @author  Aleksandr Vasilenko <info@acset.ru>
	###

	Handlebars.registerHelper 'PRICE', (price) ->
		NumFormat(price) + ' руб.'

	###*
	# Хелпер для форматирования чисел
	# @param  {int}        Число
	# @return {string}     Форматированное число
	# @author  Aleksandr Vasilenko <info@acset.ru>
	###

	Handlebars.registerHelper 'NUM', (num) ->
		NumFormat num

	###*
	# Хелпер для склонения существительных
	# @param  {int}        Число
	# @param  {str}        Ключ для поиска в словаре I18n
	# @return {str}        Число с существительным
	# @author Aleksandr Vasilenko <info@acset.ru>
	###

	Handlebars.registerHelper 'PLURAL', (num, key) ->
		number = Math.abs(num)
		plural = Handlebars.helpers.I18n(key)
		result = undefined
		number %= 100
		if number >= 5 and number <= 20
	 		result = plural.five
		else
	 		number %= 10
	 		if number == 1
	   		result = plural.one
	 		else if number >= 2 and number <= 4
	   		result = plural.two
	 		else
	   		result = plural.five
		num + ' ' + result

	Handlebars.registerHelper 'HTML::image', (image) ->
		host = if app.configs.paths.images != 'undefined' then app.configs.paths.images else '/images/'
		host + image