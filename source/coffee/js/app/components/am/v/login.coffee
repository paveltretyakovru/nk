# am - animatedmodal 
define [ 'require' , 'marionette' , 'text!am/tmpl/login.html' , 'models/user' ] , ( require , Marionette , Template , User ) ->
	'use strict'

	return Marionette.ItemView.extend
		queryUrl : '/api/v1/auth/sessions'
		template : Template
		ui 		 : 'formLogin' 				: '#form-login'
		events 	 : 'submit @ui.formLogin' 	: 'doLogin' 

		initialize 	: -> @model = app.models.user
		onRender 	: -> @binding = app.Rivets.bind @el , model : @model
		
		doLogin 	: ( event ) ->
			$.post app.hostUrl + @queryUrl , @model.toJSON() , (result) =>
				console.log 'RESULT DATA' , result
				if 'id' of result then @successLogin result else @errorLogin result
			
			event.preventDefault()

		successLogin 	: ( data ) ->
			### code ###

		errorLogin 		: ( data ) ->
			console.error 'Ошибка авторизации' , data