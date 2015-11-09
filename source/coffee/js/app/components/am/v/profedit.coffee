# am - animatedmodal 
define [ 'require' , 'marionette' , 'text!am/tmpl/profedit.html' ] , ( require , Marionette , Template ) ->
	'use strict'

	Model = Backbone.Model.extend()
	return Marionette.ItemView.extend
		template : Template
		# queryUrl : '/api/v1/auth/registrations'

		# ui 		 : 'formReg' 			: '#form-reg'
		# events 	 : 'submit @ui.formReg'	: 'doReg' 

		# initialize 	: -> @model = new Model()
		# onRender 	: -> @binding = app.Rivets.bind @el , model : @model

		# doReg : ( event ) ->
		# 	$.post app.hostUrl + @queryUrl , @model.toJSON() , (result) =>
		# 		console.log "result reg: " , result
		# 	event.preventDefault()