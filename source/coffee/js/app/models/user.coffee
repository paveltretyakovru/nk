define [ 'backbone' ] , ( Backbone ) ->
	'use strict'

	User = Backbone.Model.extend
		defaults : 
			phone 		: ''
			password 	: ''

	return User