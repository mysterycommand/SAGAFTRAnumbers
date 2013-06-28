define [
  'jquery'
  'underscore'
  'input/radio/use-broadcast'
  'input/radio/use-internet'
], ($, _, UseBroadcast, UseInternet) ->
  class UseBoth
    constructor: ->
      @label = "both as a radio broadcast, and on the Internet or in new media"
      @steps = [
        new UseBroadcast()
        new UseInternet()
      ]
      @el = []
      _.each @steps, (el, i) => @el.push el.el
      @$el = $ @el

    getSelectedItem: (index) ->
      @steps[0].getSelectedItem()

  UseBoth
