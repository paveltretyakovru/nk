define(function(require) {
  var startSlider;
  startSlider = function() {
    var autoPlayDelay, autoPlayId, autoplaySlider, checkVideo, navigationMarker, nextSlide, prevSlide, primaryNav, setAutoplay, sliderNav, slidesNumber, slidesWrapper, updateNavigationMarker, updateSliderNavigation, uploadVideo, visibleSlidePosition;
    slidesWrapper = $('.cd-hero-slider');

    /**
    		 *	Функции для запуска слайдера
     */
    nextSlide = function(visibleSlide, container, pagination, n) {
      visibleSlide.removeClass('selected from-left from-right').addClass('is-moving').one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function() {
        visibleSlide.removeClass('is-moving');
      });
      container.children('li').eq(n).addClass('selected from-right').prevAll().addClass('move-left');
      checkVideo(visibleSlide, container, n);
    };
    prevSlide = function(visibleSlide, container, pagination, n) {
      visibleSlide.removeClass('selected from-left from-right').addClass('is-moving').one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function() {
        visibleSlide.removeClass('is-moving');
      });
      container.children('li').eq(n).addClass('selected from-left').removeClass('move-left').nextAll().removeClass('move-left');
      checkVideo(visibleSlide, container, n);
    };
    updateSliderNavigation = function(pagination, n) {
      var navigationDot;
      navigationDot = pagination.find('.selected');
      navigationDot.removeClass('selected');
      pagination.find('li').eq(n).addClass('selected');
    };
    setAutoplay = function(wrapper, length, delay) {
      var autoPlayId;
      if (wrapper.hasClass('autoplay')) {
        clearInterval(autoPlayId);
        autoPlayId = window.setInterval((function() {
          autoplaySlider(length, slidesWrapper);
        }), delay);
      }
    };
    autoplaySlider = function(length, slidesWrapper) {
      var visibleSlidePosition;
      if (visibleSlidePosition < length - 1) {
        nextSlide(slidesWrapper.find('.selected'), slidesWrapper, sliderNav, visibleSlidePosition + 1);
        visibleSlidePosition += 1;
      } else {
        prevSlide(slidesWrapper.find('.selected'), slidesWrapper, sliderNav, 0);
        visibleSlidePosition = 0;
      }
      updateNavigationMarker(navigationMarker, visibleSlidePosition + 1);
      updateSliderNavigation(sliderNav, visibleSlidePosition);
    };
    uploadVideo = function(container) {
      container.find('.cd-bg-video-wrapper').each(function() {
        var video, videoUrl, videoWrapper;
        videoWrapper = $(this);
        if (videoWrapper.is(':visible')) {
          videoUrl = videoWrapper.data('video');
          video = $('<video loop><source src="' + videoUrl + '.mp4" type="video/mp4" /><source src="' + videoUrl + '.webm" type="video/webm" /></video>');
          video.appendTo(videoWrapper);
          if (videoWrapper.parent('.cd-bg-video.selected').length > 0) {
            video.get(0).play();
          }
        }
      });
    };
    checkVideo = function(hiddenSlide, container, n) {
      var hiddenVideo, visibleVideo;
      hiddenVideo = hiddenSlide.find('video');
      if (hiddenVideo.length > 0) {
        hiddenVideo.get(0).pause();
      }
      visibleVideo = container.children('li').eq(n).find('video');
      if (visibleVideo.length > 0) {
        visibleVideo.get(0).play();
      }
    };
    updateNavigationMarker = function(marker, n) {
      marker.removeClassPrefix('item').addClass('item-' + n);
    };
    $.fn.removeClassPrefix = function(prefix) {
      this.each(function(i, el) {
        var classes;
        classes = el.className.split(' ').filter(function(c) {
          return c.lastIndexOf(prefix, 0) !== 0;
        });
        el.className = $.trim(classes.join(' '));
      });
      return this;
    };
    if (slidesWrapper.length > 0) {
      console.log('slider wrapper');
      primaryNav = $('.cd-primary-nav');
      sliderNav = $('.cd-slider-nav');
      navigationMarker = $('.cd-marker');
      slidesNumber = slidesWrapper.children('li').length;
      visibleSlidePosition = 0;
      autoPlayId = void 0;
      autoPlayDelay = 5000;
      uploadVideo(slidesWrapper);
      setAutoplay(slidesWrapper, slidesNumber, autoPlayDelay);
      primaryNav.on('click', function(event) {
        if ($(event.target).is('.cd-primary-nav')) {
          $(this).children('ul').toggleClass('is-visible');
        }
      });
      return sliderNav.on('click', 'li', function(event) {
        var activePosition, selectedItem, selectedPosition;
        event.preventDefault();
        selectedItem = $(this);
        if (!selectedItem.hasClass('selected')) {
          selectedPosition = selectedItem.index();
          activePosition = slidesWrapper.find('li.selected').index();
          if (activePosition < selectedPosition) {
            nextSlide(slidesWrapper.find('.selected'), slidesWrapper, sliderNav, selectedPosition);
          } else {
            prevSlide(slidesWrapper.find('.selected'), slidesWrapper, sliderNav, selectedPosition);
          }
          visibleSlidePosition = selectedPosition;
          updateSliderNavigation(sliderNav, selectedPosition);
          updateNavigationMarker(navigationMarker, selectedPosition + 1);
          setAutoplay(slidesWrapper, slidesNumber, autoPlayDelay);
        }
      });
    }
  };
  return startSlider;
});
