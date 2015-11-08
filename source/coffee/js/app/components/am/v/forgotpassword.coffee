# am - animatedmodal 
define [ 'require' , 'marionette' , 'text!am/tmpl/forgotpassword.html' ] , ( require , Marionette , Template ) ->
	'use strict'

	Model = Backbone.Model.extend()

	return Marionette.ItemView.extend
		template : Template
		queryUrl : '/api/v1/auth/sessions.json'
		ui 		 : 'formForgotpassword' 			: '#form-forgotpassword'
		events 	 : 'submit @ui.formForgotpassword' 	: 'doForgotpassword' 

		initialize 	: -> @model = new Model()
		onRender 	: -> @binding = app.Rivets.bind @el , model : @model

		doForgotpassword : ( event ) ->
			$.post app.hostUrl + @queryUrl , @model.toJSON() , (result) =>
				console.log "result login: " , result
			event.preventDefault()