define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'
	LayoutTemplate	= require 'text!tmpls/pages/community/page_community_layoutview.html'

	GraphAlgs = require 'views/pages/community/graphalgs'

	Marionette.LayoutView.extend
		template 	: LayoutTemplate
		className 	: '.main-wrap'

		initialize : ->
			@on 'render' , @afterRender , @
		# end INITIALIZE

		afterRender : ->
			# Selectors
			@graphCanvas	= @el.querySelectorAll('#viewport')[0]			
			@graphBlock 	= @el.querySelectorAll('#community_block5')[0]
			@pBlock			= @el.querySelectorAll('p')[0]
		# end AFTER RENDER

		onShow : ->
			# Отрисовываем плавающий график
			widthGraph = @graphBlock.offsetWidth
			@graphCanvas.setAttribute 'width' , widthGraph +  widthGraph/100 * 10
			@graphCanvas.setAttribute 'height' , @graphBlock.offsetHeight
			@graph 	= new GraphAlgs @graphCanvas , 0
			
			# @graphBlock.offsetWidth/2 - @pBlock.offsetWidth/2
			# + @graphBlock.offsetHeight / 100 * 20

	# end LAYOUT VIEW