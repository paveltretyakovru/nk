# am - animatedmodal 
define [ 'require' , 'marionette' , 'text!am/tmpl/achall.html' , 'components/am/model' ] , ( require , Marionette , Template , Model ) ->
	'use strict'

	return Marionette.ItemView.extend
		template 	: Template
		initialize 	: ->
			@model = new Model
				design : true
