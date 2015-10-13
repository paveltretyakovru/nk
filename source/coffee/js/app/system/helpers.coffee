define ( require ) ->
	'use strict'

	Handlebars 	= require('handlebars')
	I18n 		= require('utils/i18n')
	NumFormat 	= require('system/libs/num_format')

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