define ( require ) ->
	'use strict'

	Marionette 	= require 'marionette'
	Template 	= require 'text!tmpls/components/animatedmodal/animatedmodal.html'

	Model = Backbone.Model.extend
		defaults :
			title 		: '[Показать окно]'			

	Marionette.LayoutView.extend
		template 			: Template
		className 			: 'animate-modal-parent'
		
		bodyView 			: {}
		frontView 			: {}
		backView 			: {}

		regions 	:
			regionFront 	: '.js-animate-modal-front'
			regionBack 		: '.js-animate-modal-back'

		ui :
			'targetLink' 		: '.js-animate-modal-target'
			'rotateLink'		: '.js-animate-modal-rotate'
			'targetBackLink'	: '.js-animate-modal-target-back'
			'targetFrontLink'	: '.js-animate-modal-target-front'

		events 				:
			'click @ui.targetLink'		: 'showModal'
			'click @ui.rotateLink'		: 'rotateModal'
			'click @ui.targetBackLink' 	: 'showBack'
			'click @ui.targetFrontLink'	: 'showFront'

		initialize : ->
			@model = new Model()

			@scaleElement			= document.getElementById 	'scale-body'	# Элемент который будет уходить назад
			@scaleClass				= 'scale-element' 							# Клас анимации ухода назад
			@fullReverseCallback 	= {} 
			
			# Ести есть заголовок, ставим заголовок для шаблона
			if not isEmpty @title then @model.set 'title' , @title

			@on 'render' , @afterRender , @

		onRender : ->
			# Если для окна нужна только одна сторона
			if not isEmpty @bodyView
				@regionFront.show @bodyView
			# Если для окна нужны две стороны (перевертышь)
			else if not isEmpty(@frontView) and not isEmpty(@backView)
				@regionFront.show 	@frontView
				@regionBack.show 	@backView

		afterRender : ->
			_this 	= @

			@$front = @regionFront.$el
			@$back 	= @regionBack.$el

			# Инициализируем анимации
			@initAnimations()

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
				if target.closest(_this.$back).length then return

				# Если окно анимировано и не активно
				if _this.sidesDroped()

					if target.closest(_this.ui.targetFrontLink).length
						_this.fullReverseCallback = _this.showFront

					if target.closest(_this.ui.targetBackLink).length
						_this.fullReverseCallback = _this.showBack

					if target.closest(_this.ui.targetLink).length
						_this.fullReverseCallback = _this.showModal

					_this.animationDropSides.reverse()
			

		showModal : ( event ) ->
			@animationDropSides.play()
			if event? then event.preventDefault()

		initAnimations : ->
			@animationDropSides = new TimelineMax paused : true
			.to @scaleElement 	, .3 	, className : '+=' + @scaleClass + ' background-color-overlay' , 0
			.to @$front , .3 , { right : '-20%' , alpha : 1 } , .3
			.to @$back  , .3 , { right : '-20%' , alpha : 1 } , .3

			@animationRotateToBack = new TimelineMax paused : true
			.set @$back , rotationX : -180
			.to @$back	, .5 	, rotationX : 0 	, .3
			.to @$front , .5 	, rotationX : 180 	, .3 # Анимация прокручивает секцию до регистрации

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