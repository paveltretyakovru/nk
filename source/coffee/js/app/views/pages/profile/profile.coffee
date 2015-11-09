define [ 'require' , 'marionette' , 'text!tmpls/pages/profile/profile.html' ] , ( Require , Marionette , PageTemplate ) ->	
	'use strict'

	Page = Marionette.LayoutView.extend
		template : PageTemplate

		onRender : -> @am = app.components.am.catch el : @el; window.am = @am # Init am [ AnimatedModals ] for views element

	return Page