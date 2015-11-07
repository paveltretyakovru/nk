
/**
 * Собираетель компанентов, собирает компаненты для занесение в app
 * @param  { Marionette.Object } 	am [ AnimatedModal ] Копанента для создания анимированных окон
 * @return { Object }    			Возвращает объект с контроллерами компанентов
 */
define(['am/am', 'app/app'], function(am, app) {
  'use strict';
  return {
    am: {
      obj: new am(),
      "catch": function(data) {
        return this.obj["catch"](data);
      }
    }
  };
});
