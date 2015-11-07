# am - animatedmodal 
define 'am/Reg' , [ 'require' , 'exports' , 'am' 	, 'am/Login' ] , (  require 	,  exports 	,  am 	, amLogin ) ->
		
	amReg = ->
		console.log 'amregistration module!'

	exports.amReg = amReg