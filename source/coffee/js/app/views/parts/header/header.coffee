define ['marionette' , 'text!tmpls/parts/header/header.html'] , ( Marionette , Template ) ->
	'use strict'

	Marionette.LayoutView.extend		
		template : Template
		tagName  : 'header'
		
		ui 		: 'linkMenu' : '.js-link-menu'
		events 	: 'click @ui.linkMenu' 	: 'showMenu'
		
		onRender : ->
			# Init am [ AnimatedModals ] for views element
			@am = new app.components.am el : @el

			window.am = @am

		showMenu : ( event ) ->	app.regionMenu.currentView.trigger 'showMenu'; event.preventDefault()