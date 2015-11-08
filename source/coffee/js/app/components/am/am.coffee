define ['require' , 'exports' , 'marionette' , 'gsap' , 'system/helpers'] , ( require , exports , Marionette ) ->
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

		cPevnt : 'add' : 'takePatient'
		cMevnt : 'add' : 'takeModal'

		initialize : ->
			@cP	= new c() # Коллекция кнопок для вызова анимированных окон
			@cM = new c() # Коллекция анимированных окон для приложения
			Marionette.bindEntityEvents @ , @cP , @cPevnt # Bind events to collection of links
			Marionette.bindEntityEvents @ , @cM , @cMevnt # Bind events to collection of modals

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
		preparePatient : ( link_object ) -> @collectModals link_object
		
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
				if isElement(val) and @getPatient({el : val}) == undefined
					# Если нет повторной кнопки сохраняем ее в коллекцию
					@cP.add el : val , to : val.getAttribute 'data-am-to'
		
		###############################################
		## Функции для работы с модальными окнами #####
		###############################################
		collectModals : ( link_object ) ->
			if not @cM.findWhere( to : link_object.to ) then @cM.add to : link_object.to , path : 'am/v/' + link_object.to

		takeModal : ( m,c,ops ) ->
			# Загружаем представление модального окна
			require [ m.toJSON().path ] , ( obj ) ->
				viewClass	= obj
				window.view = new viewClass()
				m.set 'viewClass' : viewClass , 'view' : view
				view.render()

				console.info 'Загружено представление модального окна' , m.toJSON().path , m.toJSON()
			, ( err ) ->
				console.error 'Не удалось загрузить объект модального окна' , m.toJSON().path

	return o