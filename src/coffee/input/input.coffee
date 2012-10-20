root = this
log = root.log
define = root.define

define [
  'jquery'
  'input/job-type'
], ($, JobTypeSelect) ->
	class Input
		constructor: (@el) ->
      @$el = $ @el
      @jobTypeSelect = new JobTypeSelect();
      @jobTypeSelect.$el.prependTo @$el
    
	
	Input