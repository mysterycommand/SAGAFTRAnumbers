root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
], ($, _) ->
	class RegionalNetworkProgramCommercial
    constructor: ->
      @label = "Regional Network Program Commercial"
      @html = """
        <fieldset>
          Thirteen week use.
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]
    
  RegionalNetworkProgramCommercial
