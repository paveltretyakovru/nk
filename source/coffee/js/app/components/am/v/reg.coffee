# am - animatedmodal 
define [ 'require' , 'marionette' , 'text!am/tmpl/reg.html' ] , ( require , Marionette , Template ) ->
	'use strict'

	return Marionette.ItemView.extend
		template : Template