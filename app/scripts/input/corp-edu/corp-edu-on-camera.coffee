define [
  'jquery'
  'underscore'

  'input/corp-edu/category'
  'input/corp-edu/narrator-player-extra'
], ($, _, Category, NarratorPlayerExtra) ->
  class CorpEduOnCamera
    constructor: ->
      @label = "Corporate/Educational & Non-Broadcast - (On Camera)"
      @value = "corp_edu_on_camera"
      @definitionId = "co-ed-contract"
      @headsUpItems = [
        'Night Shoots'
        'Travel time'
        'Wardrobe fees'
      ]
      @steps = [
        new Category()
        new NarratorPlayerExtra()
        # new DayPlayer()
        # new Extra()
        # new Wardrobe()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el

    destroy: ->
      @$el.off("**") # TODO: Make sure this works.

  CorpEduOnCamera
