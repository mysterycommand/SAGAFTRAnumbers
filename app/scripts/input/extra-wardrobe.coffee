define [
  'jquery'
], ($) ->
	class ExtraWardrobe
    constructor: (@index) ->
      @html = """
        <li>
          <input type="checkbox" name="extra-#{@index}-wardrobe-fitting" value="1" checked>
          <a href="#wardrobe-fitting" class="term open">wardrobe fitting</a> for general extra #{@index + 1}.
        </li>
      """
      @$el = $ @html
      @el = @$el[0]
      throw "This class was deprecated as of version 0.5!"

  ExtraWardrobe
