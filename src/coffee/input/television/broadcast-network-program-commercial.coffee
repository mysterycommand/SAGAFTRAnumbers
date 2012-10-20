root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
], ($, _) ->
	class NetworkProgramCommercial
    constructor: ->
      @label = "Network Program Commercial"
      @html = """
        <fieldset>
          In over 20 cities, with <input type="number" name="num-uses" id="num-uses" value="1" min="1"> uses.
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]
    
  NetworkProgramCommercial
