root = this
log = root.log
define = root.define

define [
	'jquery'
	'underscore'
	
	'input/radio/radio-commercial'
	'input/radio/radio-commercial-demo'
], ($, _, RadioCommercial, RadioCommercialDemo) ->
	exports = 
		'Commercial': RadioCommercial
		'Demo': RadioCommercialDemo

	exports