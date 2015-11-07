# am - animatedmodal 
define [ 'require' , 'marionette' , 'text!am/tmpl/reg.html' ] , ( require , Marionette , Template ) ->
	'use strict'

	return Marionette.LayoutView.extend
		tempalte : Template