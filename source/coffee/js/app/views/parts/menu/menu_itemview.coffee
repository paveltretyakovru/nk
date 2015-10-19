define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/menu/menu.html'
	
	Marionette = Marionette.ItemView.extend
		debug 		: true
		template 	: Template

		ui 			:
			'ClosingMenuButton'	: '#closing'

		events 		: 
			'click @ui.ClosingMenuButton' : 'closeMenu'

		initialize : ->
			console.log 'menu_itemvie.initialize' if @debug

			@on 'render'	, @afterRender	, @
			@on 'showMenu' 	, @showMenu		, @

		afterRender : ->
			@initCloseMenuAnimation()
			#@closeMenu()

		showMenu : ->			
			@closeMenuAnimation.play()

		closeMenu : ->
			TweenMax.set '#region-menu' , { autoAlpha : 1 , opacity : 1 }
			console.log 'Click close element'
			@closeMenuAnimation.reverse()

		initCloseMenuAnimation	: ->

			t1 		= new TimelineMax paused : true
			lpm 	= @el.querySelectorAll("#lpm")
			rpm 	= @el.querySelectorAll("#rpm")
			bco 	= @el.querySelectorAll("#bco")
			body 	= document.body
			@scaleBody 	= document.getElementById 'scale-body'
			@scaleClass	= 'scale-element' # Клас анимации ухода назад

			t1
			.to @scaleBody 		, .5 , { className : @scaleClass , ease : Expo.easeInOut } , 0
			.to '#region-menu' 	, .5 , { autoAlpha : .7 , ease : Expo.easeInOut } , 0
			.to lpm , 1.2 , 
				left 			: '0%'
				autoAlpha 	 	: 1
				ease 			: Expo.easeInOut
			,	0

			.to rpm , 1.2 ,
				right 			: "0%"
				autoAlpha 	 	: 1
				ease 			: Expo.easeInOut
			, 	0

			@closeMenuAnimation = t1