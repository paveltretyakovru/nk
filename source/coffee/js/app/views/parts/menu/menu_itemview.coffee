define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/menu/menu.html'
	
	Marionette = Marionette.ItemView.extend
		debug 		: true
		template 	: Template

		ui 			:
			'ClosingMenuButton'	: '.js-closing-menu'
			'MenuSiteLinks'		: '.link-site-menu'

		events 		: 
			'click @ui.ClosingMenuButton' 	: 'closeMenu'
			'click @ui.MenuSiteLinks'		: 'closeMenu'

		initialize : ->
			console.log 'menu_itemvie.initialize' if @debug


			@on 'render'	, @afterRender	, @
			@on 'showMenu' 	, @showMenu		, @

		onRender : ->
			@lpm 	= @el.querySelectorAll("#lpm")
			@rpm 	= @el.querySelectorAll("#rpm")
			@scaleBody 	= document.getElementById 'scale-body'
			@scaleClass	= 'scale-element' # Клас анимации ухода назад

			@initCloseMenuAnimation()

		afterRender : ->
			#

		showMenu : ->
			@closeMenuAnimation.play()

		closeMenu : ->
			TweenMax.set '#region-menu' , { autoAlpha : 1 , opacity : 1 }
			@closeMenuAnimation.reverse()

		initCloseMenuAnimation	: ->

			t1 		= new TimelineLite paused : true

			t1
			.to @scaleBody 		, .5 , { className : '+=' + @scaleClass , ease : Expo.easeInOut } , 0
			.to '#region-menu' 	, .3 , { autoAlpha : 1 , ease : Expo.easeInOut } , 0
			.to @lpm , 1 , 
				left 			: '0%'
				autoAlpha 	 	: 1
				ease 			: Expo.easeInOut
			,	0

			.to @rpm , 1 ,
				right 			: "0%"
				autoAlpha 	 	: 1
				ease 			: Expo.easeInOut
			, 	0

			@closeMenuAnimation = t1