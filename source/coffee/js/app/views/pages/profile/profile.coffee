define [ 'require' , 'marionette' , 'text!tmpls/pages/profile/profile.html' ] , ( Require , Marionette , PageTemplate ) ->	
	'use strict'

	Page = Marionette.LayoutView.extend
		template : PageTemplate

	return Page