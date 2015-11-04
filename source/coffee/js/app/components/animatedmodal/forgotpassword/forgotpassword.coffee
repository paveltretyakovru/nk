define ( require ) ->
	'use strict'

	Marionette 		= require 'marionette'
	AnimatedModal 	= require 'components/animatedmodal/animatedmodal'

	###*
	 * Манипуляция через шаблон
	###
	# %a.js-animate-modal-target-back Show back 	клик по ссылке выводит обратную сторону модального окна
	# %a.js-animate-modal-target-front Show front 	клик по ссылке выводит фронтальную часть модального окна
	# %a.js-animate-modal-rotate Rotate modal		клик по ссылке переворачивает окно на противоположную сторону

	FrontView 		= Marionette.ItemView.extend
		template : 'Front view <a href="#" class="js-animate-modal-rotate">Перевернуть</a>'

	BackView 		= Marionette.ItemView.extend
		template : 'Back view <a href="#" class="js-animate-modal-rotate">Перевернуть</a>'

	ComponentItem = Marionette.ItemView.extend
		template : "Type component template"

	AnimatedModal.extend
		# Подпись ссылки
		title		: 'Забыли пароль?'
		
		# Если необходимо составить переворачиваемое окно
		frontView 	: new FrontView()
		backView 	: new BackView()

		# Если нужен только перед
		# bodyView	: new ComponentItem()