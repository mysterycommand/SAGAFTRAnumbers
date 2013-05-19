define [
  'jquery'
  'underscore'
  'input/television/use-broadcast-on-camera'
  'input/television/use-internet'
], ($, _, UseBroadcast, UseInternet) ->
	class UseBoth
    constructor: ->
      @label = "both as a television broadcast, and on the Internet or in new media"
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
