root = this
log = root.log
define = root.define

define [
	'jquery'
	'input/job-type'
	'touchable/draggable-number'
	'chosen'
], ($, JobType, DraggableNumber) ->
	class Input
		constructor: (@el) ->
			@$el = $ @el
			@jobType = new JobType();
			@jobType.$el.prependTo @$el
			
			@$el.on 'input change', @onChange
		
		onChange: (event) =>
			# log 'Input.onChange', event.type, event.target.id
			# if event.type is 'input'
			#   event.preventDefault()
			#   event.stopPropagation()
			#   @$el.trigger 'change'
			#   return
			
			# if $(event.target).is('#job-type') and parseInt($('#job-type').val(), 10) is -1 then @clear()
			# @$el.find('.chzn-select').not('.chzn-done').each (i, el) ->
			# 	$(el).chosen
			# 		allow_single_deselect: ( !! $(el).find('option[value=-1]').size())
			# 		disable_search_threshold: 20
			
			@$el.find('input[type=number]').not('.draggable-number').each (i, el) -> new DraggableNumber el
			
			return
		
		clear: () ->
			@jobType.$el.find('#job-type').val(-1).trigger('liszt:updated').trigger('change')
	
	Input