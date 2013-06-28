define [
  'jquery'
], ($) ->
  class ActorWardrobe
    constructor: (@index) ->
      @html = """
        <li>
          <input type="checkbox" name="actor-#{@index}-wardrobe-fitting" value="1" checked>
          <a href="#wardrobe-fitting" class="term open">wardrobe fitting</a> for principal actor #{@index + 1}.
        </li>
      """
      @$el = $ @html
      @el = @$el[0]
      throw "This class was deprecated as of version 0.5!"

  ActorWardrobe
