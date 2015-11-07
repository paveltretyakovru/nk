
/**
 * Собираетель компанентов, собирает компаненты для занесение в app
 * @param  { Marionette.Object } am [ AnimatedModal ] Копанента для создания анимированных окон
 * @return { Object }    			Возвращает объект с контроллерами компанентов
 */
define(['am/am'], function(am) {
  'use strict';
  return {
    am: am
  };
});
