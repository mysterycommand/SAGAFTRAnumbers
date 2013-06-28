define [
  'jquery'
  'underscore'
  'input/television/day'
], ($, _, Day) ->
  class PublicServiceAnnouncementTelevisionOnCamera
    constructor: ->
      @label = "Public Service Announcement - Television (On Camera)"
      @value = "psa_television_on_camera"
      @definitionId = "psa"
      @steps = [
        new Day()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el

    destroy: ->
      @$el.off("**") # TODO: Make sure this works.

  PublicServiceAnnouncementTelevisionOnCamera
