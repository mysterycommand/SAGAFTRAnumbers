define [
  'jquery'
  'underscore'
  'input/radio/actor-announcer-singer'
  'input/version'
], ($, _, ActorAnnouncerSinger, Version) ->
  class RadioCommercialUse
    constructor: ->
      @label = "Radio Commercial Demo"
      @value = "radio_commercial_demo"
      @definitionId = "radio-commercial-demo"
      @headsUpItems = [
        'Holiday pay'
        'Lifts'
      ]
      @steps = [
        new ActorAnnouncerSinger()
        new Version()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el

    destroy: ->
      @$el.off("**") # TODO: Make sure this works.

  RadioCommercialUse
