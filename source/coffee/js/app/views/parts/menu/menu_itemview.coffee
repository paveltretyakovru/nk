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
			'click @ui.MenuSiteLinks'		: 'clickMenuLinks'

		initialize : ->

			@on 'render'		, @afterRender			 , @
			@on 'showMenu' 		, @showMenu				 , @
			@on 'hashUpdated' 	, @selectCurrentItemMenu , @

		onRender : ->
			@lpm 	= @el.querySelectorAll("#lpm")
			@rpm 	= @el.querySelectorAll("#rpm")
			@scaleBody 	= document.getElementById 'scale-body'
			@scaleClass	= 'scale-element' # Клас анимации ухода назад

			@initMenuAnimation()

		afterRender : ->
			### code ... ###

		clickMenuLinks : ( e ) ->
			@selectCurrentItemMenu()
			@closeMenu()

		showMenu : ->
			@showMenuAnimation.play()

		closeMenu : ->
			@showMenuAnimation.reverse()

		###*
		# selectCurrentItemMenu обновляет стили ссылок в меню в зависимости от текущего url
		###
		selectCurrentItemMenu : ->			
			now		= if location.hash != '' then location.hash else '#'
			all 	= @el.querySelectorAll('a')

			for i in [ 0...all.length ]
				removeClass all[i] , 'text-color-orange'

			currect = findAttr('href='+now , all )

			if currect? and currect.length > 0
				for i in [ 0...currect.length ]
					addClass currect[i] , 'text-color-orange'

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