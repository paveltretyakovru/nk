define ['require' , 'exports' , 'marionette' , 'gsap' , 'system/helpers'] , ( require , exports , Marionette ) ->
	'use strict'
	
	###*
	 * Сокращения: m-model; c-collection; o-object; am-anmatedmodals
	###

	m = Backbone.Model.extend()
	c = Backbone.Collection.extend()
	
	o = Marionette.Object.extend
		el : {}	# Селектор, который будет обрабатываться объектом

		mEvents : {}	# Listen model events
		cEvents : {}	# Listen collection events

		initialize : ( ops ) ->
			# Init variables
			@options = ops
			@m 		 = new m()
			@c 		 = new c model : @m

			# Bind events			
			Marionette.bindEntityEvents @ , @m , @mEvents
			Marionette.bindEntityEvents @ , @c , @cEvents

		collectPatients : ->
			if Marionette.isNodeAttached @options.el then console.log 'Atached!'

	return o