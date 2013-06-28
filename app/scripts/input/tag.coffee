define [
  'jquery'
], ($) ->
  class Tag
    constructor: ->
      @html = """
        <fieldset>
          I'll need
          <input type="number" name="num-tags" id="num-tags" value="0" min="0">
          <a href="#tag" class="term open">tag</a>(s) for this commercial.
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]

  Tag
