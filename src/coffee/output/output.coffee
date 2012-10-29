root = this
log = root.log
define = root.define

define [
	'jquery'
	'output/estimator'
	'output/radio'
	'output/television'
	'output/psa'
	'output/corp-edu'
], ($, Estimator, Radio, Television, PSA, CorpEdu) ->
	class Output
		constructor: (@el) ->
			@$el = $ @el
			@sessionFeesEstimator = new Estimator "Session Fees Subtotal", "session-fees"
			@usageFeesEstimator = new Estimator "Usage Fees Subtotal", "usage-fees"
			@type = 'none'
		
		clear: ->
			@$el.find('tbody').remove()
		
		onChange: (event) =>
			# log event.type, event.target.id
			# event.preventDefault()
			# event.stopPropagation()
			
			$targ = $(event.target)
			if $targ.is '#job-type'
				type = $targ.find("[value=#{$targ.val()}]").data 'value'
				if @type isnt type
					@type = type
					@rates = root.sag_aftra_rates[@type]
					# log @type, @rates

			@clear()
			@html = ''
			@cost = 0
			
			@[@type]() unless @type is 'none'
			
			@$el.find('thead').after(@html)
			
			agents10 = @cost * 0.1
			subtotal = @cost + agents10
			hrph = subtotal * 0.155
			payroll = subtotal * 0.14
			total = subtotal + hrph + payroll
			
			$('#estimate-agents-10 .amount').text agents10.toFixed(2)
			$('#subtotal .amount').text subtotal.toFixed(2)
			$('#estimate-hr-ph .amount').text hrph.toFixed(2)
			$('#estimate-payroll-taxes .amount').text payroll.toFixed(2)
			$('#total .amount').text total.toFixed(2)
			$('#hud-total .amount').text total.toFixed(2)
			
			@$el.trigger 'change'
			return
		
		radio_commercial: ->
			@sessionFeesEstimator.estimate Radio.sessionLineItems @rates
			@usageFeesEstimator.estimate Radio.usageLineItems @rates
			
			@html = @sessionFeesEstimator.html + @usageFeesEstimator.html
			@cost = @sessionFeesEstimator.cost + @usageFeesEstimator.cost
			return
		
		radio_commercial_demo: ->
			@sessionFeesEstimator.estimate Radio.sessionLineItems @rates
			
			@html = @sessionFeesEstimator.html
			@cost = @sessionFeesEstimator.cost
			return
		
		television_commercial_on_camera: ->
			@sessionFeesEstimator.estimate Television.onCameraSessionLineItems @rates
			@usageFeesEstimator.estimate Television.usageLineItems @rates
			
			@html = @sessionFeesEstimator.html + @usageFeesEstimator.html
			@cost = @sessionFeesEstimator.cost + @usageFeesEstimator.cost
			return
		
		television_commercial_off_camera: ->
			@sessionFeesEstimator.estimate Television.offCameraSessionLineItems @rates
			@usageFeesEstimator.estimate Television.usageLineItems @rates
			
			@html = @sessionFeesEstimator.html + @usageFeesEstimator.html
			@cost = @sessionFeesEstimator.cost + @usageFeesEstimator.cost
			return
		
		television_commercial_demo: ->
			@sessionFeesEstimator.estimate Television.demoSessionLineItems @rates
			
			@html = @sessionFeesEstimator.html
			@cost = @sessionFeesEstimator.cost
			return
		
		psa_radio: ->
			@sessionFeesEstimator.estimate PSA.radioSessionLineItems @rates
			
			@html = @sessionFeesEstimator.html
			@cost = @sessionFeesEstimator.cost
			return
		
		psa_television_on_camera: ->
			@sessionFeesEstimator.estimate PSA.tvOnCameraSessionLineItems @rates
			
			@html = @sessionFeesEstimator.html
			@cost = @sessionFeesEstimator.cost
			return
		
		psa_television_off_camera: ->
			@sessionFeesEstimator.estimate PSA.tvOffCameraSessionLineItems @rates
			
			@html = @sessionFeesEstimator.html
			@cost = @sessionFeesEstimator.cost
			return

		corp_edu_on_camera: ->
			@sessionFeesEstimator.estimate CorpEdu.onCameraSessionLineItems @rates
			
			@html = @sessionFeesEstimator.html
			@cost = @sessionFeesEstimator.cost
			return
		
		corp_edu_off_camera: ->
			@sessionFeesEstimator.estimate CorpEdu.offCameraSessionLineItems @rates
			
			@html = @sessionFeesEstimator.html
			@cost = @sessionFeesEstimator.cost
			return
		
		corp_edu_audio_only: ->
			# @sessionFeesEstimator.estimate CorpEdu.audioOnlySessionLineItems @rates
			@sessionFeesEstimator.estimate CorpEdu.offCameraSessionLineItems @rates # It looks llke these are the same.
			
			@html = @sessionFeesEstimator.html
			@cost = @sessionFeesEstimator.cost
			return
	
	Output
