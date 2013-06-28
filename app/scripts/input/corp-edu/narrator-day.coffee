define [
  'jquery'
], ($) ->
  class NarratorDay
    constructor: (@index) ->
      @html = """
        <p>
          I'll need narrator/spokesperson #{@index} for
          <input type="number" name="narrator-#{@index}-num-days" id="narrator-#{@index}-num-days" class="num-days" value="1" min="1" max="10">
          day(s).
        </p>

      """
      @$el = $ @html
      @el = @$el[0]

  NarratorDay
