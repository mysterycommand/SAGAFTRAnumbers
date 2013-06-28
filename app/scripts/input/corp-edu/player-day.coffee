define [
  'jquery'
], ($) ->
  class PlayerDay
    constructor: (@index) ->
      @html = """
        <p>
          I'll need day player #{@index} for
          <input type="number" name="player-#{@index}-num-days" id="player-#{@index}-num-days" class="num-days" value="1" min="1" max="10">
          day(s).
        </p>

      """
      @$el = $ @html
      @el = @$el[0]

  PlayerDay
