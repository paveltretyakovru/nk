define ['require' , 'exports' , 'marionette' , 'gsap' , 'system/helpers'] , ( require , exports , Marionette ) ->
	'use strict'
	
	###*
	 * Сокращения: m-model; c-collection; o-object; am-anmatedmodals; ops-options
	###

	m = Backbone.Model.extend()
	c = Backbone.Collection.extend model : m
	
	o = Marionette.Object.extend
		mEvents : {} # Listen collection and model events
		cEvents : 'add' : 'takePatient'

		initialize : ( ops ) ->			
			@options = ops 	# Init variables
			@m 		 = new m()
			@c 		 = new c()
			
			Marionette.bindEntityEvents @ , @m , @mEvents 	# Bind events
			Marionette.bindEntityEvents @ , @c , @cEvents
			
			@collectPatients()

		collectPatients : -> # Finding patients
			el 	 = @getOption 'el' # !=am! finding our links # Элемент dom, для поиска пациентов
			find = if el? then el.querySelectorAll '[data-component=am]' # saving our links in collection
			for i , f of find then if isElement f then @c.add el : f , to : f.getAttribute 'data-am-to'
		
		takePatient 	: (m,c,ops) -> # geting new element in collection
			data = m.toJSON()

	return o