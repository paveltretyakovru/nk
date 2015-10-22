define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'
	LayoutTemplate 	= require 'text!tmpls/pages/philosophie/page_philosophie_layoutview.html'

	Marionette.LayoutView.extend
		template : LayoutTemplate
