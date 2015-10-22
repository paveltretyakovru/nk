define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'

	LayoutTemplate	= require 'text!tmpls/pages/community/page_community_layoutview.html'

	Marionette.LayoutView.extend
		template : LayoutTemplate
