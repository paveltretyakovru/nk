# am - animatedmodal 
define [ 'require' , 'marionette' , 'text!am/tmpl/login.html' ] , ( require , Marionette , Template ) ->
	'use strict'

	Model = Backbone.Model.extend()

	return Marionette.ItemView.extend
		template : Template
		ui 		 : 'formLogin' : '#form-login'
		events 	 : 'submit @ui.formLogin' : 'doLogin' 

		initialize 	: -> @model = new Model()
		onRender 	: -> @binding = app.Rivets.bind @el , model : @model

		doLogin 	: ( event ) ->
			$.post app.hostUrl + '/api/v1/auth/sessions', @model.toJSON() , (result) =>
				console.log "result login: " , result
			event.preventDefault()