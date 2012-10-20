root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
  'input/television/principal-actor'
  'input/version'
  'input/tag'
], ($, _, PrincipalActor, Version, Tag) ->
	class TelevisionCommercialOffCamera
    constructor: ->
      @label = "Television Commercial - (Voiceover/Off Camera)"
      @steps = [
        new PrincipalActor()
        new Version()
        new Tag()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el
    
    destroy: ->
      @$el.off("**") # TODO: Make sure this works.
  
  TelevisionCommercialOffCamera