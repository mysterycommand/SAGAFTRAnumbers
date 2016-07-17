define [
  'jquery'
  'underscore'
], ($, _) ->
  class Internet4Week
    constructor: ->
      @label = "4 Week Option"
      @html = """
        <!-- NO OP -->
      """
      @$el = $ @html
      @el = @$el[0]

  Internet4Week
