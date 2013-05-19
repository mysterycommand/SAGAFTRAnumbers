define [
  'jquery'
  'underscore'
  'input/television/principal-actor'
  'input/version'
  'input/tag'
  'input/television/use-off-camera'
], ($, _, PrincipalActor, Version, Tag, Use) ->
	class TelevisionCommercialOffCamera
    constructor: ->
      @label = "Television Commercial - (Voiceover/Off Camera)"
      @value = "television_commercial_off_camera"
      @definitionId = "tv-commercial"
      @headsUpItems = [
        'Lifts'
        'Non-broadcast use'
      ]
      @steps = [
        new PrincipalActor()
        new Version()
        new Tag()
        new Use()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el

    destroy: ->
      @$el.off("**") # TODO: Make sure this works.

  TelevisionCommercialOffCamera
