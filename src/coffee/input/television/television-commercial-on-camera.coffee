root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
  
  'input/television/day'
  'input/television/use'
], ($, _, Day, Use) ->
	class TelevisionCommercialOnCamera
    constructor: ->
      @label = "Television Commercial - (On Camera)"
      @value = "television_commercial_on_camera"
      @definitionId = "tv-commercial"
      @steps = [
        new Day()
        new Use()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el
    
    destroy: ->
      @$el.off("**") # TODO: Make sure this works.
  
  TelevisionCommercialOnCamera