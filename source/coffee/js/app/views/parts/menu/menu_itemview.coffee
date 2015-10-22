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

			@initMenuAnimation()

		afterRender : ->
			#

		showMenu : ->
			@showMenuAnimation.play()

		closeMenu : ->
			#TweenMax.set '#region-menu' , { autoAlpha : 1 , opacity : 1 }
			@showMenuAnimation.reverse()

		initMenuAnimation	: ->

			t1 		= new TimelineLite paused : true

			t1
			.set [ @lpm , @rpm ] , autoAlpha : 1
			.to @scaleBody 		, .3 , { className : '+=' + @scaleClass } , 0
			.to '#region-menu' 	, .3 , { autoAlpha : 1 , ease : Expo.easeInOut } , .3
			.to @lpm , .5 , 
				left 			: '0%'				
				ease 			: Expo.easeInOut
			,	.6

			.to @rpm , .5 ,
				right 			: "0%"
				ease 			: Expo.easeInOut
			, 	.8

			@showMenuAnimation = t1