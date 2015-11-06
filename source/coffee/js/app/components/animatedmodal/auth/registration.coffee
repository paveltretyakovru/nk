# am - animatedmodal 
define 'amRegistration' ,
	[ 'require' , 'exports' , 'AnimatedModal' 	, 'amLogin' ] ,
	(  require 	,  exports 	,  AnimatedModal 	, amLogin ) ->
		
		amRegistration = ->
			console.log 'amregistration module!'

		exports.amRegistration = amRegistration