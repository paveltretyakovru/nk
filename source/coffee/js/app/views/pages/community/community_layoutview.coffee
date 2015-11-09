define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'
	LayoutTemplate	= require 'text!tmpls/pages/community/page_community_layoutview.html'

	Nodes = require 'views/pages/community/nodes'

	Marionette.LayoutView.extend
		template 	: LayoutTemplate
		className 	: '.main-wrap'

		initialize : ->

			@on 'render' , @afterRender , @
		# end INITIALIZE

		onShow : ->
			w = @$el.find("#viewport-left").width()
			h = @$el.find("#viewport-left").height()
			# Отрисовываем плавающий график
			@nodesLeft = new Nodes 'viewport-left', w, h
			@nodesLeft.render

			@nodesRight = new Nodes 'viewport-right', w, h
			@nodesRight.render

