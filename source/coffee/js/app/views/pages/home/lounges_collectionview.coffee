define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'

	childView 	= Marionette.ItemView.extend
		template 	: "<div class='frontside' style='color:{{ color }}'><img src='src/images/blazons/{{ blazon }}'><h4>«{{ title }}»</h4><small>{{ city }}</small></div><div class='backside'><img src='src/images/reverse-side.jpg' style='width: 100%; height: 100%'></div>"
		tagName 	: 'article'
		className 	: 'lounge'

	Collection 	= Backbone.Collection.extend()

	data 		= [ 	
		title	: 'blazon'
		blazon 	: 'gerb_spb_blazon.svg'
		city	: 'Тюмень'
		color 	: '#7DBE6D'
	,
		title	: 'Академия'
		blazon 	: 'gerb_spb_academy.svg'
		city	: 'Санкт-Петербург'
		color 	: '#5F4D9B'
	,
		title	: 'Либерти'
		blazon 	: 'gerb_spb_liberty.svg'
		city	: 'Санкт-Петербург'
		color 	: '#65B6DC'
	,
		title	: 'unity hall'
		blazon 	: 'gerb_kazan_unityhall.svg'
		city	: 'Казань'
		color 	: '#E76144'
	]


	Marionette.CollectionView.extend
		childView : childView
		collection : new Collection data

		initialize : ->
			console.log 'initialize  collectionview'