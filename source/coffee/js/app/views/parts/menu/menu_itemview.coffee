define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/parts/menu/menu.html'
	
	Marionette = Marionette.ItemView.extend
		debug 		: true
		template 	: Template

		initialize : ->
			console.log 'menu_itemvie.initialize' if @debug

			@on 'render'	, @afterRender	, @
			@on 'showMenu' 	, @showMenu		, @

		afterRender : ->
			@initCloseMenuAnimation()

		showMenu : ->
			@closeMenuAnimation.play()

		closeMenu : ->
			@closeMenuAnimation.reverse()


		initCloseMenuAnimation	: ->

			t1 		= new TimelineMax paused : true
			lpm 	= @el.querySelectorAll("#lpm")
			rpm 	= @el.querySelectorAll("#rpm")
			bco 	= @el.querySelectorAll("#bco")
			body 	= document.body

			t1

			.to body , 0.5 ,
				scale 			: 1
				webkitFilter	:"blur(0)"
				ease 			:"{Power4.easeOut}"

			.to lpm , 1.2 ,
				left 		 	: "-20%"
				autoAlpha 	 	: 0
				immediateRender : true
				ease 			: Expo.easeInOut
			,	0

			.to rpm , 1.2 ,
				right 			: "-20%"
				autoAlpha 		: 0
				immediateRender : true
				ease 			: Expo.easeInOut
			, 	0

			.to bco , 1.2 ,
				autoAlpha		: 0
				immediateRender	:true
				ease 			: Expo.easeInOut
			, 	0

			@closeMenuAnimation = t1;

			#TweenMax.set body , { scale : 1 	 , webkitFilter	:"blur(0)"  , ease :"{Power4.easeOut}"}
			#TweenMax.set lpm  , { left  : "-20%" , autoAlpha : 0 }
			#TweenMax.set rpm  , { left  : "-20%" , autoAlpha : 0 }
			#TweenMax.set bco  , autoAlpha : 0