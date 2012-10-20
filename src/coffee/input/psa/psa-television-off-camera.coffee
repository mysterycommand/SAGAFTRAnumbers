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
	class PublicServiceAnnouncementTelevisionOffCamera
    constructor: ->
      @label = "Public Service Announcement - Television (Off Camera)"
      @value = "psa_television_off_camera"
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
  
  PublicServiceAnnouncementTelevisionOffCamera