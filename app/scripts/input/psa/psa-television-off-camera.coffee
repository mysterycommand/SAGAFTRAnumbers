define [
  'jquery'
  'underscore'
  'input/television/principal-actor'
  'input/version'
  'input/tag'
], ($, _, PrincipalActor, Version, Tag) ->
  class PublicServiceAnnouncementTelevisionOffCamera
    constructor: ->
      @label = "Public Service Announcement - Television (Voiceover/Off Camera)"
      @value = "psa_television_off_camera"
      @definitionId = "psa"
      @steps = [
        new PrincipalActor()
        new Version()
        # new Tag()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el

    destroy: ->
      @$el.off("**") # TODO: Make sure this works.

  PublicServiceAnnouncementTelevisionOffCamera
