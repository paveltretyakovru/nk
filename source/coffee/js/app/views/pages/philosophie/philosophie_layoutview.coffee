define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'
	LayoutTemplate 	= require 'text!tmpls/pages/philosophie/page_philosophie_layoutview.html'
	Scrollfade		= require 'behaviors/scrollfade/scrollfade'

	Marionette.LayoutView.extend
		template : LayoutTemplate

		behaviors :
			scrollfade :
				behaviorClass : Scrollfade