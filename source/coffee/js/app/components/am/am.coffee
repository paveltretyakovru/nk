define ['require' , 'exports' , 'marionette' , 'gsap' , 'system/helpers'] , ( require , exports , Marionette ) ->
	'use strict'	
	###*
	 * Сокращения: m-model; c-collection; o-object; am-anmatedmodals; ops-options
	 * [cP]-коллекция пациентов:) <- ссылки по которыем приклепляются окна
	###
	c = Backbone.Collection.extend()
	o = Marionette.Object.extend
		cEnt : 'add' : 'takePatient'

		initialize : ->
			@cP	= new c() # Init patients links collection
			Marionette.bindEntityEvents @ , @cP , @cPEvnt # Bind events links collection

		catch : ( ops ) ->
			@options = ops
			@collectPatients()	# Перебрать и собрать переданых пациентов

		###############################################
		## Функции для работы с пациентами (links) ####
		###############################################
		collectPatients : ->
			el 	 = @getOption 'el' # Элемент dom, для поиска пациентов
			find = if el? then el.querySelectorAll '[data-component=am]' # saving our links in collection
			
			for i , val of find  # Перебираем удовлетворяющие элементы дума
				# Последнее свойство селектора length :)
				if isElement(val) and @getPatient {el : val}					
					@cP.add el : val , to : val.getAttribute 'data-am-to'					
		
		takePatient	: (m,c,ops) -> # geting new element in collection
			data = m.toJSON()

		getPatient : ( id ) ->
			result = @cP.findWhere id
			console.log 'Result get' , result

			return result

	return o