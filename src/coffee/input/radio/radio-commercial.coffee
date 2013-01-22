root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
  'input/radio/actor-announcer-singer'
  'input/version'
  'input/tag'
  'input/radio/use'
], ($, _, ActorAnnouncerSinger, Version, Tag, Use) ->
	class RadioCommercial
    constructor: ->
      @label = "Radio Commercial"
      @value = "radio_commercial"
      @definitionId = "radio-commercial"
      @headsUpItems = [
        'Lifts'
        'Non-broadcast use'
      ]
      @steps = [
        new ActorAnnouncerSinger()
        new Version()
        new Tag()
        new Use()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el
    
    destroy: ->
      @$el.off("**") # TODO: Make sure this works.
  
  RadioCommercial