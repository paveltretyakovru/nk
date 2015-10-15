/**
 *	Утилита предназначена для запука виджетов vk.com после рендеринга страницы
 */
define(function( require ){
	'use strict';

	/**
	 * Инициализируем главную функцию конструктор
	 * @return {[type]} [description]
	 */
	var vk = function(){
		// Инициализируем ВК API
        VK.init({ apiId: 'codocot.local' });
	}

	/**
	 * Описываем селектор и его зависимость соответствуюзего плагина api vk
	 * @type {Object}
	 */
	vk.prototype.deps = {

	}

	return vk;

});