define(function(require) {
  'use strict';
  var Handlebars, I18n, NumFormat;
  Handlebars = require('handlebars');
  I18n = require('utils/i18n');
  NumFormat = require('system/libs/num_format');
  window.addClass = function(el, className) {
    if (el.classList != null) {
      return el.classList.add(className);
    } else {
      return el.classList += ' ' + className;
    }
  };
  window.removeClass = function(el, className) {
    var reg;
    if (el.classList) {
      return el.classList.remove(className);
    } else {
      reg = new RegExp('(^|\\b)' + className.split(' ').join('|') + '(\\b|$)', 'gi');
      return el.className = el.className.replace(reg, ' ');
    }
  };
  window.addEvent = function(el, eventName, callback) {
    if (el.addEventListener) {
      return el.addEventListener(eventName, callback, false);
    } else if (el.attachEvent) {
      console.log('Attach event');
      return el.attachEvent('on' + eventName, callback);
    }
  };

  /**
  	 * Хелпер для интернационализации
  	 * @param  {String}     Ключ для поиска перевода
  	 * @return {string}     Найденный перевод в словаре
  	 * @author  Aleksandr Vasilenko <info@acset.ru>
   */
  Handlebars.registerHelper('I18n', function(str) {
    if (typeof I18n !== 'undefined') {
      return I18n.t(str);
    } else {
      return str;
    }
  });

  /**
  	 * Хелпер для форматирования цен
  	 * @param  {int}        Цена
  	 * @return {string}     Форматированную цену с валютой
  	 * @author  Aleksandr Vasilenko <info@acset.ru>
   */
  Handlebars.registerHelper('PRICE', function(price) {
    return NumFormat(price) + ' руб.';
  });

  /**
  	 * Хелпер для форматирования чисел
  	 * @param  {int}        Число
  	 * @return {string}     Форматированное число
  	 * @author  Aleksandr Vasilenko <info@acset.ru>
   */
  Handlebars.registerHelper('NUM', function(num) {
    return NumFormat(num);
  });

  /**
  	 * Хелпер для склонения существительных
  	 * @param  {int}        Число
  	 * @param  {str}        Ключ для поиска в словаре I18n
  	 * @return {str}        Число с существительным
  	 * @author Aleksandr Vasilenko <info@acset.ru>
   */
  Handlebars.registerHelper('PLURAL', function(num, key) {
    var number, plural, result;
    number = Math.abs(num);
    plural = Handlebars.helpers.I18n(key);
    result = void 0;
    number %= 100;
    if (number >= 5 && number <= 20) {
      result = plural.five;
    } else {
      number %= 10;
      if (number === 1) {
        result = plural.one;
      } else if (number >= 2 && number <= 4) {
        result = plural.two;
      } else {
        result = plural.five;
      }
    }
    return num + ' ' + result;
  });
  return Handlebars.registerHelper('HTML::image', function(image) {
    var host;
    host = app.configs.paths.images !== 'undefined' ? app.configs.paths.images : '/images/';
    return host + image;
  });
});
