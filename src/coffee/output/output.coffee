root = this
log = root.log
define = root.define

define [
  'jquery'
], ($) ->
	class Output
		constructor: (@el) ->
      @$el = $ @el
    
    clear: ->
      # log "Hi!"
	
	Output
