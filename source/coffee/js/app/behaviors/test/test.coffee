define ( require ) ->
	'use strict'

	Marionette = require 'marionette'

	window.Behaviors['test'] = Marionette.Behavior.extend
		ui :
			test : '.test'

		events :
			"click @ui.test" : 'showTestMessage'

		showTestMessage : ->
			alert 'Test alert from Behavior!'