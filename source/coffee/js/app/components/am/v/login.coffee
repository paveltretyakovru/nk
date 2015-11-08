# am - animatedmodal 
define [ 'require' , 'marionette' , 'text!am/tmpl/login.html' ] , ( require , Marionette , Template ) ->
	'use strict'

	return Marionette.ItemView.extend
		template : Template