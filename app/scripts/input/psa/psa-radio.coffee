define [
  'jquery'
  'underscore'
  'input/radio/actor-announcer-singer'
  'input/version'
], ($, _, ActorAnnouncerSinger, Version) ->
	class PublicServiceAnnouncementRadio
    constructor: ->
      @label = "Public Service Announcement - Radio"
      @value = "psa_radio"
      @definitionId = "psa"
      @steps = [
        new ActorAnnouncerSinger()
        new Version()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el

    destroy: ->
      @$el.off("**") # TODO: Make sure this works.

  PublicServiceAnnouncementRadio
