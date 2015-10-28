define ( require ) ->

	startSlider = ->

		slidesWrapper = $('.cd-hero-slider')		

		###*
		#	Функции для запуска слайдера
		###
		nextSlide = (visibleSlide, container, pagination, n) ->
			visibleSlide.removeClass('selected from-left from-right').addClass('is-moving').one 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
				visibleSlide.removeClass 'is-moving'
				return
			container.children('li').eq(n).addClass('selected from-right').prevAll().addClass 'move-left'
			checkVideo visibleSlide, container, n
			return

		prevSlide = (visibleSlide, container, pagination, n) ->
			visibleSlide.removeClass('selected from-left from-right').addClass('is-moving').one 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
				visibleSlide.removeClass 'is-moving'
				return
			container.children('li').eq(n).addClass('selected from-left').removeClass('move-left').nextAll().removeClass 'move-left'
			checkVideo visibleSlide, container, n
			return

		updateSliderNavigation = (pagination, n) ->
			navigationDot = pagination.find('.selected')
			navigationDot.removeClass 'selected'
			pagination.find('li').eq(n).addClass 'selected'
			return

		setAutoplay = (wrapper, length, delay) ->
			if wrapper.hasClass('autoplay')
				clearInterval autoPlayId
				autoPlayId = window.setInterval((->
					autoplaySlider length , slidesWrapper
					return
				), delay)
			return

		autoplaySlider = (length , slidesWrapper) ->
			if visibleSlidePosition < length - 1
				nextSlide slidesWrapper.find('.selected'), slidesWrapper, sliderNav, visibleSlidePosition + 1
				visibleSlidePosition += 1
			else
				prevSlide slidesWrapper.find('.selected'), slidesWrapper, sliderNav, 0
				visibleSlidePosition = 0
			updateNavigationMarker navigationMarker, visibleSlidePosition + 1
			updateSliderNavigation sliderNav, visibleSlidePosition
			return

		uploadVideo = (container) ->
			container.find('.cd-bg-video-wrapper').each ->
				videoWrapper = $(this)
				if videoWrapper.is(':visible')
					# if visible - we are not on a mobile device 
					videoUrl = videoWrapper.data('video')
					video = $('<video loop><source src="' + videoUrl + '.mp4" type="video/mp4" /><source src="' + videoUrl + '.webm" type="video/webm" /></video>')
					video.appendTo videoWrapper
					# play video if first slide
					if videoWrapper.parent('.cd-bg-video.selected').length > 0
						video.get(0).play()
				return
			return

		checkVideo = (hiddenSlide, container, n) ->
			#check if a video outside the viewport is playing - if yes, pause it
			hiddenVideo = hiddenSlide.find('video')
			if hiddenVideo.length > 0
				hiddenVideo.get(0).pause()
			#check if the select slide contains a video element - if yes, play the video
			visibleVideo = container.children('li').eq(n).find('video')
			if visibleVideo.length > 0
				visibleVideo.get(0).play()
			return

		updateNavigationMarker = (marker, n) ->
			marker.removeClassPrefix('item').addClass 'item-' + n
			return	

		$.fn.removeClassPrefix = (prefix) ->
			#remove all classes starting with 'prefix'
			@each (i, el) ->
				classes = el.className.split(' ').filter((c) ->
					c.lastIndexOf(prefix, 0) != 0
				)
				el.className = $.trim(classes.join(' '))
				return
			this

		#check if a .cd-hero-slider exists in the DOM 
		if slidesWrapper.length > 0
			console.log 'slider wrapper'
			primaryNav = $('.cd-primary-nav')
			sliderNav = $('.cd-slider-nav')
			navigationMarker = $('.cd-marker')
			slidesNumber = slidesWrapper.children('li').length
			visibleSlidePosition = 0
			autoPlayId = undefined
			autoPlayDelay = 5000
			#upload videos (if not on mobile devices)
			uploadVideo slidesWrapper
			#autoplay slider
			setAutoplay slidesWrapper, slidesNumber, autoPlayDelay
			#on mobile - open/close primary navigation clicking/tapping the menu icon
			primaryNav.on 'click', (event) ->
				if $(event.target).is('.cd-primary-nav')
					$(this).children('ul').toggleClass 'is-visible'
				return
			#change visible slide
			sliderNav.on 'click', 'li', (event) ->
				event.preventDefault()
				selectedItem = $(this)
				if !selectedItem.hasClass('selected')
					# if it's not already selected
					selectedPosition = selectedItem.index()
					activePosition = slidesWrapper.find('li.selected').index()
					if activePosition < selectedPosition
						nextSlide slidesWrapper.find('.selected'), slidesWrapper, sliderNav, selectedPosition
					else
						prevSlide slidesWrapper.find('.selected'), slidesWrapper, sliderNav, selectedPosition
					#this is used for the autoplay
					visibleSlidePosition = selectedPosition
					updateSliderNavigation sliderNav, selectedPosition
					updateNavigationMarker navigationMarker, selectedPosition + 1
					#reset autoplay
					setAutoplay slidesWrapper, slidesNumber, autoPlayDelay
				return	

	return startSlider