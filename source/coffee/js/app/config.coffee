requirejs.config
	'baseUrl'	: '/'
	'paths'		: 'requirejs'

	# CORE
	'requirejs'				: 'bower_components/requirejs/require'
	'text'					: 'bower_components/requirejs-text/text'
	'i18n'					: 'bower_components/requirejs-i18n/i18n'
	'jquery'				: 'bower_components/jquery/dist/jquery.min'
	'underscore'			: 'bower_components/underscore/underscore-min'
	'backbone'				: 'bower_components/backbone/backbone-min'
	'backbone.babysitter'	: 'bower_components/backbone.babysitter/lib/backbone.babysitter.min'
	'backbone.wreqr'		: 'bower_components/backbone.wreqr/lib/backbone.wreqr.min'
	'backbone.deep-model'	: 'bower_components/backbone-deep-model/distribution/deep-model.min'
	'backbone.rivets'		: 'bower_components/rivets-backbone-adapter/rivets-backbone'
	'marionette'			: 'bower_components/marionette/lib/core/backbone.marionette.min'
	'marionette.component'	: 'bower_components/marionette.component/dist/marionette.component.min'
	'handlebars'			: 'bower_components/handlebars/handlebars.min'
	'rivets'				: 'bower_components/rivets/dist/rivets'
	'sightglass'			: 'bower_components/sightglass/index'
	'backbone-validation'	: 'bower_components/backbone-validation/dist/backbone-validation-min'

    # PATH
	'app'           		: 'js/app'
	'nls'           		: 'js/app/nls'
	'utils'         		: 'js/app/utils'
	'tmpls'         		: 'js/app/templates'
	'views'         		: 'js/app/views'
	'models'        		: 'js/app/models'
	'system'        		: 'js/app/system'
	'components'    		: 'js/app/components'
	'controllers'   		: 'js/app/controllers'
	'collections'   		: 'js/app/collections'
	'widgets'       		: 'js/app/widgets'

    # TESTS
	'spec'					: 'js/app/tests/spec'
	'sinon'					: 'bower_components/sinonjs/sinon'
	'jasmine'				: 'bower_components/jasmine/lib/jasmine-core/jasmine'
	'jasmine-html'			: 'bower_components/jasmine/lib/jasmine-core/jasmine-html'
	'jasmine-ajax'			: 'bower_components/jasmine-ajax/lib/mock-ajax'
	'jasmine-sinon'			: 'bower_components/jasmine-sinon/lib/jasmine-sinon'
	'jasmine-jquery'		: 'bower_components/jasmine-jquery/lib/jasmine-jquery'
	'boot'					: 'bower_components/jasmine/lib/jasmine-core/boot'

	'shim':
		'jquery'				: 'exports': '$'
		'underscore'			: 'exports': '_'
		'handlebars'			: 'exports': 'Handlebars'		
		'backbone'				: 'exports': 'Backbone' , 'deps': [ 'jquery' , 'underscore'] 	
		'marionette'			: 'exports': 'Marionette' , 'deps': [ 'jquery' , 'underscore' , 'backbone' , 'backbone.babysitter' , 'backbone.wreqr' ]
		'marionette.component'	: 'deps': [ 'marionette' ]		
		'backbone.deep-model'	: 'deps': [ 'jquery' , 'backbone' , 'underscore' ]
		'rivets'				: 'deps': [ 'sightglass' ]		
		'backbone.rivets'		: 'deps': [ 'backbone' , 'rivets' ]
		'backbone-validation'	: 'deps': [ 'jquery' , 'backbone' ]
		'bootstrap'				: 'deps': [ 'jquery' ]
		'pace'					: 'deps': [ 'jquery' ]		
		'jasmine'				: 'exports': 'window.jasmineRequire'
		'jasmine-html'			: 'deps': [ 'jasmine' ] , 'exports': 'jasmine-html'
		'jasmine-sinon'			: 'deps': [ 'jasmine' , 'boot' , 'sinon' ] , 'exports': 'jasmine-sinon'
		'jasmine-jquery'		: 'deps': [ 'jasmine' , 'boot' , 'jquery' ] , 'exports': 'jasmine-jquery'
		'boot'					: 'deps': [ 'jasmine' , 'jasmine-html'] , 'exports': 'boot'

	config: i18n: locale: 'ru-ru'	