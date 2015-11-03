define(function(require) {
  'use strict';
  var Handlebars, I18n, NumFormat, hasOwnProperty;
  Handlebars = require('handlebars');
  I18n = require('utils/i18n');
  NumFormat = require('system/libs/num_format');
  hasOwnProperty = Object.prototype.hasOwnProperty;

  /**
  	 * Прооверяет obj на пустоту
  	 * @param  {mixed} переменная для проверки на пустоту
  	 * @return {Boolean}
   */
  window.isEmpty = function(obj) {
    var key;
    if (obj === null) {
      return true;
    }
    if (obj.length > 0) {
      return false;
    }
    if (obj.length === 0) {
      return true;
    }
    for (key in obj) {
      if (hasOwnProperty.call(obj, key)) {
        return false;
      }
    }
    return true;
  };
  window.isString = function(variable) {
    return typeof variable === "string";
  };
  window.isArray = function(variable) {
    return Array.isArray(variable);
  };
  window.isFunction = function(functionToCheck) {
    var getType;
    getType = {};
    return functionToCheck && getType.toString.call(functionToCheck) === '[object Function]';
  };
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
  window.randomInteger = function(min, max) {
    var rand;
    rand = min + Math.random() * (max - min);
    rand = Math.round(rand);
    return rand;
  };
  window.findAttr = function(selector, findin) {
    var allElements, arr, attr, attrValue, elemAttr, i, j, matchingElements, ref;
    matchingElements = [];
    allElements = findin != null ? findin : document.getElementsByTagName('*');
    arr = selector.split('=');
    if (arr.length > 1) {
      attr = arr[0];
      attrValue = arr[1];
    } else {
      attrValue = arr[0];
    }
    for (i = j = 0, ref = allElements.length; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      if (attr != null) {
        elemAttr = allElements[i].getAttribute(attr);
        if (elemAttr != null) {
          if (elemAttr === attrValue) {
            matchingElements.push(allElements[i]);
          }
        }
      } else {
        console.error("Неправильный формат параметра переданного в функцию");
      }
    }
    return matchingElements;
  };
  window.getHashValue = function(key) {
    var matches;
    matches = location.hash.match(new RegExp(key + '=([^&]*)'));
    if (matches) {
      return matches[1];
    } else {
      return null;
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
