root = this
log = root.log
define = root.define

define [
  'jquery'
], ($) ->
	class ExtraWardrobe
    constructor: (@index) ->
      @html = """
        <li>
          <input type="checkbox" name="extra-#{@index}-wardrobe-fitting" value="1" checked>
          wardrobe fitting for general extra #{@index + 1}.
        </li>
      """
      @$el = $ @html
      @el = @$el[0]
  
  ExtraWardrobe
