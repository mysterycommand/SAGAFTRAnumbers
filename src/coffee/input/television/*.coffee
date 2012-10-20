root = this
log = root.log
define = root.define

define [
	'jquery'
	'underscore'
	
	'input/television/television-commercial-on-camera'
	'input/television/television-commercial-off-camera'
	'input/television/television-commercial-demo'
], ($, _, TelevisionCommercialOnCamera, TelevisionCommercialOffCamera, TelevisionCommercialDemo) ->
	exports = 
		'OnCamera': TelevisionCommercialOnCamera
		'OffCamera': TelevisionCommercialOffCamera
		'Demo': TelevisionCommercialDemo

	exports