define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'

	LayoutTemplate	= require 'text!tmpls/pages/community/page_community_layoutview.html'

	require 'onepage-scroll'

	Marionette.LayoutView.extend
		template : LayoutTemplate

		initialize : ->
			@on 'render' , @afterRender , @

		afterRender : ->
			#@$el.onepage_scroll()