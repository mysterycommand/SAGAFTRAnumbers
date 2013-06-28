define [
  'jquery'
  'underscore'
], ($, _) ->
  class DealerCommercial
    constructor: ->
      @label = "Dealer Commercial"
      @html = """
        <fieldset>
          Six month use.
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]

  DealerCommercial
