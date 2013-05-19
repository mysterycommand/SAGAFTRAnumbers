define [
  'jquery'
], ($) ->
	class Version
    constructor: ->
      @html = """
        <fieldset>
          There is
          <input type="number" name="num-versions" id="num-versions" value="1" min="1" max="10">
          <a href="#version" class="term open">version</a>(s) of the script.
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]

  Version
