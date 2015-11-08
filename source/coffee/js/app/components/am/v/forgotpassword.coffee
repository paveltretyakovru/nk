# am - animatedmodal 
define [ 'require' , 'marionette' , 'text!am/tmpl/forgotpassword.html' ] , ( require , Marionette , Template ) ->
	'use strict'

	Model = Backbone.Model.extend()

	return Marionette.ItemView.extend
		template : Template
		ui 		 : 'formForgotpassword' : '#form-forgotpassword'
		events 	 : 'submit @ui.formForgotpassword' : 'doLogin' 

		initialize 	: -> @model = new Model()
		onRender 	: -> @binding = app.Rivets.bind @el , model : @model

		doLogin : ( event ) ->
			$.post app.hostUrl + '/api/v1/auth/sessions.json', @model.toJSON() , (result) =>
				console.log "result login: " , result
			event.preventDefault()