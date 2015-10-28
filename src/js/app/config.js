requirejs.config({
  'paths': {
    'requirejs': 'client/bower_components/requirejs/require',
    'text': 'client/bower_components/requirejs-text/text',
    'i18n': 'client/bower_components/requirejs-i18n/i18n',
    'jquery': 'client/bower_components/jquery/dist/jquery.min',
    'underscore': 'client/bower_components/underscore/underscore-min',
    'backbone': 'client/bower_components/backbone/backbone-min',
    'backbone.babysitter': 'client/bower_components/backbone.babysitter/lib/backbone.babysitter',
    'backbone.wreqr': 'client/bower_components/backbone.wreqr/lib/backbone.wreqr.min',
    'backbone.deep-model': 'client/bower_components/backbone-deep-model/distribution/deep-model.min',
    'backbone.rivets': 'client/bower_components/rivets-backbone-adapter/rivets-backbone',
    'marionette': 'client/bower_components/marionette/lib/core/backbone.marionette',
    'marionette.component': 'client/bower_components/marionette.component/dist/marionette.component.min',
    'handlebars': 'client/bower_components/handlebars/handlebars.min',
    'rivets': 'client/bower_components/rivets/dist/rivets',
    'sightglass': 'client/bower_components/sightglass/index',
    'backbone-validation': 'client/bower_components/backbone-validation/dist/backbone-validation-min',
    'gsap': 'client/bower_components/gsap/src/minified/TweenMax.min',
    'jquery-ui': 'client/bower_components/jquery-ui/jquery-ui.min',
    'syphon': 'client/bower_components/backbone.syphon/lib/backbone.syphon.min',
    'app': 'src/js/app',
    'nls': 'src/js/app/nls',
    'utils': 'src/js/app/utils',
    'tmpls': 'src/js/app/templates',
    'views': 'src/js/app/views',
    'models': 'src/js/app/models',
    'system': 'src/js/app/system',
    'components': 'src/js/app/components',
    'controllers': 'src/js/app/controllers',
    'collections': 'src/js/app/collections',
    'widgets': 'src/js/app/widgets',
    'pace': 'client/bower_components/pace/pace.min',
    'fullpagejs': 'client/bower_components/fullpage.js/jquery.fullPage.min',
    'arbor': 'client/bower_components/arbor/lib/arbor',
    'arbor-graphics': 'client/bower_components/arbor/demos/_/graphics',
    'spec': 'src/js/app/tests/spec',
    'sinon': 'client/bower_components/sinonjs/sinon',
    'jasmine': 'client/bower_components/jasmine/lib/jasmine-core/jasmine',
    'jasmine-html': 'client/bower_components/jasmine/lib/jasmine-core/jasmine-html',
    'jasmine-ajax': 'client/bower_components/jasmine-ajax/lib/mock-ajax',
    'jasmine-sinon': 'client/bower_components/jasmine-sinon/lib/jasmine-sinon',
    'jasmine-jquery': 'client/bower_components/jasmine-jquery/lib/jasmine-jquery',
    'boot': 'client/bower_components/jasmine/lib/jasmine-core/boot'
  },
  'shim': {
    'jquery': {
      'exports': '$'
    },
    'jquery-ui': {
      'deps': ['jquery']
    },
    'underscore': {
      'exports': '_'
    },
    'handlebars': {
      'exports': 'Handlebars'
    },
    'backbone': {
      'exports': 'Backbone',
      'deps': ['jquery', 'underscore']
    },
    'marionette': {
      'exports': 'Marionette',
      'deps': ['jquery', 'underscore', 'backbone', 'backbone.babysitter', 'backbone.wreqr']
    },
    'marionette.component': {
      'deps': ['marionette']
    },
    'backbone.deep-model': {
      'deps': ['jquery', 'backbone', 'underscore']
    },
    'rivets': {
      'deps': ['sightglass']
    },
    'backbone.rivets': {
      'deps': ['backbone', 'rivets']
    },
    'backbone-validation': {
      'deps': ['jquery', 'backbone']
    },
    'bootstrap': {
      'deps': ['jquery']
    },
    'pace': {
      'deps': ['jquery']
    },
    'jasmine': {
      'exports': 'window.jasmineRequire'
    },
    'jasmine-html': {
      'deps': ['jasmine'],
      'exports': 'jasmine-html'
    },
    'jasmine-sinon': {
      'deps': ['jasmine', 'boot', 'sinon'],
      'exports': 'jasmine-sinon'
    },
    'jasmine-jquery': {
      'deps': ['jasmine', 'boot', 'jquery'],
      'exports': 'jasmine-jquery'
    },
    'boot': {
      'deps': ['jasmine', 'jasmine-html'],
      'exports': 'boot'
    },
    'fullpagejs': {
      'deps': ['jquery']
    },
    'arbor': {
      'deps': ['jquery']
    },
    'arbor-graphics': {
      'deps': ['jquery']
    }
  },
  config: {
    i18n: {
      locale: 'ru-ru'
    }
  }
});
