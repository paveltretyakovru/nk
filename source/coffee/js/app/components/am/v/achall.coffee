# am - animatedmodal 
define [ 'require' , 'marionette' , 'text!am/tmpl/achall.html' ] , ( require , Marionette , Template ) ->
	'use strict'

	Model = Backbone.Model.extend()
	return Marionette.ItemView.extend
		template : Template