require [ 'app/app' , 'pace' ] , ( app , pace ) ->
	'use strict'

	pace.on 'start' , ->
		console.log 'pace start'

	pace.start
		document : false
