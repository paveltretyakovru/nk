define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/components/animatedmodal/animatedmodal.html'

	Model = Backbone.Model.extend
		defaults :
			title 		: '[Показать окно]'			

	AnimatedModalModule = Marionette.LayoutView.extend
		template 			: Template

		scaleElement		: document.getElementById 	'scale-body'	# Элемент который будет уходить назад
		scaleClass			: 'scale-element' 							# Клас анимации ухода назад
		fullReverseCallback : {} 

		regions 	:
			regionBodyComponent 	: '.animatedmodal-side' # Сюда будет заливаться вид самого компонента

		ui :
			'targetLink' 		: '.js-animate-modal-target'
			#'rotateLink'		: '.js-animate-modal-rotate'
			#'targetBackLink'	: '.js-animate-modal-target-back'
			#'targetFrontLink'	: '.js-animate-modal-target-front'

		events 				:
			'click @ui.targetLink'		: 'showModal'
			#'click @ui.rotateLink'		: 'rotateModal'
			#'click @ui.targetBackLink' 	: 'showBack'
			#'click @ui.targetFrontLink'	: 'showFront'

		initialize : ->
			console.log 'Initialize animatedmodal' , @name
			
			@model = new Model()			
			if not isEmpty @title then @model.set 'title' , @title # Ести есть заголовок, ставим заголовок для шаблона

			@on 'render' , @afterRender , @

		afterRender : ->
			console.log 'TEST HERE!!!' , @name , @bodyView

			@regionBodyComponent.on 'show' , @onRegionBodyComponentShow , @
			@regionBodyComponent.show @bodyView

		onRegionBodyComponentShow : ->
			@$front = @regionBodyComponent.$el
			console.log 'onShow!' , @el , @$front			
			# Инициализируем анимации
			@initAnimations()			

		showModal : ( event ) ->
			@animationDropSides.play()
			if event? then event.preventDefault()

		initAnimations : ->
			_this 	= @

			@animationDropSides = new TimelineMax paused : true
			.to @scaleElement 	, .3 	, className : '+=' + @scaleClass + ' background-color-overlay' , 0
			.to @$front 		, .3 	, { right : '-20%' , alpha : 1 } , .3
			#.to @$back  , .3 , { right : '-20%' , alpha : 1 } , .3

			@animationRotateToBack = new TimelineMax paused : true
			#.set @$back , rotationX : -180
			#.to @$back	, .5 	, rotationX : 0 	, .3
			.to @$front , .5 	, rotationX : 180 	, .3 # Анимация прокручивает секцию до регистрации

			@animationDropSides.eventCallback 'onReverseComplete' , =>
				if @toBackRotated()
					@animationRotateToBack.reverse()
				else if not isEmpty @fullReverseCallback
					@fullReverseCallback()
					@fullReverseCallback = {}

			@animationRotateToBack.eventCallback 'onReverseComplete' , =>
				if not isEmpty @fullReverseCallback
					@fullReverseCallback()
					@fullReverseCallback = {}

			# Прослушиваем клик вне логин формы
			$(@scaleElement).on 'click' , (event) ->
				target = $ event.target

				# Проверяем, не произошел ли клик в окне
				if target.closest(_this.$front).length then return
				#if target.closest(_this.$back).length then return

				# Если окно анимировано и не активно
				if _this.sidesDroped()

					if target.closest(_this.ui.targetFrontLink).length
						_this.fullReverseCallback = _this.showFront

					if target.closest(_this.ui.targetBackLink).length
						_this.fullReverseCallback = _this.showBack

					if target.closest(_this.ui.targetLink).length
						_this.fullReverseCallback = _this.showModal

					_this.animationDropSides.reverse()

		# Проверяет состоияние сексции выдвинута ли она || анимация не активна и анимирована
		sidesDroped : ->
			return not @animationDropSides.isActive() and @animationDropSides.progress()

		toBackRotated : ->
			return not @animationRotateToBack.isActive() and @animationRotateToBack.progress()

		rotateModal : ( event ) ->
			if @sidesDroped() and not @toBackRotated()
				@animationRotateToBack.play()
			else
				@animationRotateToBack.reverse()

			if event? then event.preventDefault()

		showFront 	: ( event ) ->
			if not @sidesDroped()
				@animationDropSides.play()

			if event? then event.preventDefault()

		showBack	: ( event ) ->
			if not @sidesDroped()
				@animationRotateToBack.eventCallback 'onComplete' , =>
					@animationDropSides.play()
					@animationRotateToBack.eventCallback 'onComplete' , null

				@animationRotateToBack.play()

			if event? then event.preventDefault()

		initParentData : ( el ) ->
			result 		= {}
			result.data = {}

			data 				= if not isEmpty el.dataset then el.dataset else {}			
			result.data.to 		= if 'animatedmodalTo' of data then data.animatedmodalTo else ''

			console.log 'Parent data' , result.data

			return result

	return AnimatedModalModule