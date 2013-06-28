define [
  'jquery'
  'underscore'

  'input/television/day'
  'input/television/use-on-camera'
], ($, _, Day, Use) ->
  class TelevisionCommercialOnCamera
    constructor: ->
      @label = "Television Commercial - (On Camera)"
      @value = "television_commercial_on_camera"
      @definitionId = "tv-commercial"
      @headsUpItems = [
        'Night Shoots'
        'Hazard Pay'
        'Travel time'
        'General Extra 13-Week rate'
      ]
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
