root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
  'input/television/day'
  'input/version'
], ($, _, Day, Version) ->
	class PublicServiceAnnouncementTelevisionOnCamera
    constructor: ->
      @label = "Public Service Announcement - Television (On Camera)"
      @steps = [
        new Day()
        new Version()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el
    
    destroy: ->
      @$el.off("**") # TODO: Make sure this works.
  
  PublicServiceAnnouncementTelevisionOnCamera