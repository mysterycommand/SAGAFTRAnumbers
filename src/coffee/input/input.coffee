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
      
      @$el.on 'change', @onChange
    
    onChange: (event) =>
      @$el.find('.chzn-select').not('.chzn-done').chosen({allow_single_deselect: true, disable_search_threshold: 20})
      @$el.find('input[type=number]').not('.draggable-number').each (i, el) -> new DraggableNumber el
    
    clear: () ->
      @jobType.$el.find('#job-type').val(-1).trigger('liszt:updated').trigger('change')
	
	Input