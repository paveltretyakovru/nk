define ['require' , 'exports' , 'marionette' , 'components/am/model' , 'gsap' , 'system/helpers' ] , ( require , exports , Marionette , mM ) ->
	'use strict'	
	###*
	 * Сокращения: [m]-model; [c]-collection; [o]-object; [am]-anmatedmodals; [ops]-options
	 * [cP]-коллекция пациентов:) <- ссылки по которыем приклепляются окна
	 * [cM]-коллекция модальных окон
	###
	c = Backbone.Collection.extend()
	o = Marionette.Object.extend
		el : {}
		cP : {}
		cM : {}
		region 	: {}
		front 	: el : {} , view : {}
		back 	: el : {} , view : {}
		current : el : {} , view : {}

		scaleElement 		: document.getElementById 	'scale-body'	# Элемент который будет уходить назад
		scaleClass 			: 'scale-element' 							# Клас анимации ухода назад
		fullReverseCallback : {} 

		cPevnt : 'add' : 'takePatient'
		cMevnt : 'add' : 'takeModal'

		initialize : ->
			@cP	= new c() # Коллекция кнопок для вызова анимированных окон
			@cM = new c() # Коллекция анимированных окон для приложения
			Marionette.bindEntityEvents @ , @cP , @cPevnt # Bind events to collection of links
			Marionette.bindEntityEvents @ , @cM , @cMevnt # Bind events to collection of modals

			# Подготавливаем HTML площадку
			@region 			= document.createElement 'div'
			@front.el 			= document.createElement 'div'
			@back.el 			= document.createElement 'div'
			
			@region.id 			= 'region-am'
			@back.el.id 		= 'am-back'
			@front.el.id 		= 'am-front'
			
			@front.el.className = 'am-side'
			@back.el.className 	= 'am-side'

			document.body.appendChild @region
			@region.appendChild @back.el
			@region.appendChild @front.el

			# Инициализируем анимации
			@initAnimation()		

		###*
		 * @param  {mixed} ops должен содерать объект el с селектором для поиска ссылок на анимации
		###
		catch : ( ops ) ->
			@options = ops
			@collectPatients()	# Перебрать и собрать переданых пациентов			

		###############################################
		## Функции для работы с пациентами (links) ####
		###############################################		
		###*
		 * @return {Void} Подготовка элемента ссылок 
		###
		preparePatient : ( link_object ) ->

			# Устанавливаем клик на новую найденую сслыку
			link_object.el.addEventListener 'click' , =>
				console.log 'CLICK ELEMENT'
				@setCurrent view : link_object.view , el : @cM.findWhere( view : link_object.view ).get('viewObj').el
				@showModal( link_object )

			@collectModals link_object
		
		###*
		 * @return {Mixed} Ищет пациента в коллекции] 
		###
		getPatient  : ( id ) -> return @cP.findWhere id
		
		###*
		 * @return {Void} Вызывает метод подготовки новго линка после добавления в коллекцию
		###
		takePatient	: ( m,c,ops ) -> @preparePatient m.toJSON()

		###*
		 * @return {void} добавляет в коллекцию компанентские кнопки
		###
		collectPatients : ->
			# Элемент dom, для поиска пациентов
			el 	 = @getOption 'el'
			# saving our links in collection
			find = if el? then el.querySelectorAll '[data-component=am]'
			
			# Перебираем удовлетворяющие элементы дума
			for i , val of find 
				# Последнее свойство селектора length :)
				if isElement(val)
					# Если нет повторной кнопки сохраняем ее в коллекцию
					@cP.add el : val , view : val.getAttribute 'data-am-view'
		
		###############################################
		## Функции для работы с модальными окнами #####
		###############################################
		collectModals : ( link_object ) ->
			if not @cM.findWhere( view : link_object.view ) then @cM.add view : link_object.view , path : 'am/v/' + link_object.view

		takeModal : ( m,c,ops ) ->
			# Загружаем представление модального окна
			require [ m.toJSON().path ] , ( obj ) =>
				viewClass = obj
				viewObj   = new viewClass()
				
				data = 'view' : m.toJSON().view , 'viewClass' : viewClass , 'viewObj' : viewObj
				if viewObj.model 
					_.extend data , viewObj.model.toJSON()
				else
					tM = new mM()
					_.extend data , tM.toJSON()
				m.set( data )
				
				# Проверяем загруженное представление на наличие ссылок компоненты
				viewObj.on 'render' , => @catch el : viewObj.el , @
				viewObj.render()				
				

				console.info 'Загружено представление модального окна' , m.toJSON().path , m.toJSON()
			, ( err ) ->
				console.error 'Не удалось загрузить объект модального окна' , m.toJSON().path

		###############################################
		## Функции для работы с анимациями ############
		###############################################
		setCurrent : ( options ) ->
			@current.el 	= options.el
			@current.view 	= options.view

		setFront : ->
			@front.el.innerHTML = ''
			@front.el.appendChild @current.el
			@front.view = @current.view	

		setBack : ->
			@back.el.innerHTML = ''
			@back.el.appendChild @current.el
			@back.view = @current.view

		initAnimation : ->
			@createAnimation()

			# Прослушиваем клик вне логин формы
			$(@scaleElement).on 'click' , (event) =>
				target = $ event.target 

				# Проверяем, не произошел ли клик в окне
				if target.closest(@$front).length then return
				if target.closest(@$back).length then return

				# Если окно анимировано и не активно
				if @animationDropSides.progress()
					@animationDropSides.reverse()
		
		createAnimation : ->
			@animationDropSides = new TimelineMax
				paused 				: true
				onStart 			: => @setFront()
				onReverseComplete 	: =>
					if @animationRotateToBack.progress()
						@animationRotateToBack.reverse()
			.set @back.el 		, rotationX : -180
			#.to @scaleElement 	, .3 	, className : '+=' + @scaleClass + ' background-color-overlay bg_testing' , 0
			.to @scaleElement 	, .6 	, className : '+=bg_testing' , 0			
			.to @front.el 		, .6 , { right : '-20%' , alpha : 1 } , .6
			.to @back.el  		, .6 , { right : '-20%' , alpha : 1 } , .6

			@animationRotateToBack = new TimelineMax
				paused 	: true
				onStart : => @setBack()
			.set @back.el , rotationX : -180
			.to @back.el  , .10 	, rotationX : 0 	, .6
			.to @front.el , .10 	, rotationX : 180 	, .6 # Анимация прокручивает секцию до регистрации
		
		showModal : ( options ) ->
			if @animationDropSides.progress()
				if @animationRotateToBack.progress()
					@setFront()
					@animationRotateToBack.reverse()
				else
					@animationRotateToBack.play()
			else
				@animationDropSides.play()

	return o