define ['marionette' , 'text!tmpls/parts/header/header.html'] , ( Marionette , Template ) ->
	'use strict'

	Marionette.LayoutView.extend		
		template : Template
		tagName  : 'header'		
		ui 		 : 'linkMenu' 			: '.js-link-menu'
		events 	 : 'click @ui.linkMenu'	: 'showMenu'
		
		onRender : -> @am = app.components.am.catch el : @el; window.am = @am # Init am [ AnimatedModals ] for views element
		showMenu : ( event ) ->	app.regionMenu.currentView.trigger 'showMenu'; event.preventDefault()