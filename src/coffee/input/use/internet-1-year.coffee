root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
], ($, _) ->
	class Internet1Year
    constructor: ->
      @label = "1 Year Option"
      @html = """
        <!-- NO OP -->
      """
      @$el = $ @html
      @el = @$el[0]
  
  Internet1Year
