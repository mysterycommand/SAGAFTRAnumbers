define [
  'jquery'
  'underscore'
], ($, _) ->
	class Internet8Week
    constructor: ->
      @label = "8 Week Option"
      @html = """
        <!-- NO OP -->
      """
      @$el = $ @html
      @el = @$el[0]

  Internet8Week
