define [
  'jquery'
  'underscore'
  'input/television/principal-actor-demo'
  'input/version'
], ($, _, PrincipalActorDemo, Version) ->
  class TelevisionCommercialDemo
    constructor: ->
      @label = "Television Commercial Demo - (Voiceover/Off Camera, Non-air)"
      @value = "television_commercial_demo"
      @definitionId = "tv-commercial-demo"
      @headsUpItems = [
        'Lifts'
        'Holiday pay'
      ]
      @steps = [
        new PrincipalActorDemo()
        new Version()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el

    destroy: ->
      @$el.off("**") # TODO: Make sure this works.

  TelevisionCommercialDemo
